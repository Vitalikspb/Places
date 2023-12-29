//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit
import GoogleMaps
import CoreLocation

protocol MapDisplayLogic: AnyObject {
    // выбран маркер и показывается floating view
    func displayChoosenDestination(viewModel: MapViewModel.ChoosenDestinationView.ViewModel, selectedSight: Sight)
    // выбран маркер и только выделен
    func displaySelectedDestination(viewModel: MapViewModel.ChoosenDestinationView.ViewModel)
    // показываем все маркеры
    func displayMarkers(filter: [GMSMarker])
    // Отображаем маркеры при вводе текста из поиска в ScrollView (TopViewSearch)
    func displayFetchedMarkersFromSearchView(withString: String)
    // Показать пустые марекры по всем городам
    func displayEmptyMarkers(markers: [GMSMarker])
}

class MapController: UIViewController {
    
    enum MapViewZoom {
        case mapViewZoom
        case countryViewZoom
        case countryView
    }
    
    // MARK: - Public Properties
    
    var interactor: MapBussinessLogic?
    var router: (NSObjectProtocol & MapRoutingLogic)?
    
    // MARK: - Private Properties
    
    // Наблюдатель интернета
    private let connectivity = Connectivity.shared
    private var internetConnection: Bool = false
    
    private var myCurrentLatitude: CLLocationDegrees = 0.0
    private var myCurrentLongitude: CLLocationDegrees = 0.0
    
    private var cameraLatitude: CLLocationDegrees = 0.0
    private var cameraLongitude: CLLocationDegrees = 0.0
    private let cameraZoom: Float = 14
    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition(latitude: myCurrentLatitude, longitude: myCurrentLongitude, zoom: cameraZoom)
        return GMSMapView(frame: .zero, camera: camera)
    }()
    
    struct BoxLocation {
        let city: String
        let locationTopLeft: CLLocationCoordinate2D
        let locationBottomRight: CLLocationCoordinate2D
    }
    
    private let boxCoordinates: [BoxLocation] = [
        BoxLocation(city: "Санкт-Петербург",
                    locationTopLeft: CLLocationCoordinate2D(latitude: 60.31961681279438, longitude: 29.585249237716198),
                    locationBottomRight: CLLocationCoordinate2D(latitude: 59.57383080890553, longitude: 30.90297561138868)),
        BoxLocation(city: "Москва",
                    locationTopLeft: CLLocationCoordinate2D(latitude: 55.955849789458455, longitude: 37.26121544837952),
                    locationBottomRight: CLLocationCoordinate2D(latitude: 55.54466329428275, longitude: 37.997560277581215)),
        BoxLocation(city: "Казань",
                    locationTopLeft: CLLocationCoordinate2D(latitude: 56.02572240735774, longitude: 48.57145484536886),
                    locationBottomRight: CLLocationCoordinate2D(latitude: 55.57000451930346, longitude: 49.41308006644249)),
        BoxLocation(city: "Екатеринбург",
                    locationTopLeft: CLLocationCoordinate2D(latitude: 57.07664797854804, longitude: 60.24093154817819),
                    locationBottomRight: CLLocationCoordinate2D(latitude: 56.50053613115544, longitude: 61.167368553578854)),
        BoxLocation(city: "Нижний Новгород",
                    locationTopLeft: CLLocationCoordinate2D(latitude: 56.47673492166995, longitude: 43.732723295688636),
                    locationBottomRight: CLLocationCoordinate2D(latitude: 56.16222099006549, longitude: 44.3244719132781)),
        BoxLocation(city: "Новосибирск",
                    locationTopLeft: CLLocationCoordinate2D(latitude: 55.114609766088186, longitude: 82.68754318356514),
                    locationBottomRight: CLLocationCoordinate2D(latitude: 54.94406906602763, longitude: 83.0907827988267))]
    
    // для определения местоположения и погоды
    private var observation: NSKeyValueObservation?
    private var location: CLLocation? {
        didSet {
            guard oldValue == nil,
                  let firstLocation = location else { return }
            mapView.camera = GMSCameraPosition(target: firstLocation.coordinate, zoom: cameraZoom)
        }
    }
    private var locationManager = CLLocationManager()
    private let userDefault = UserDefaults.standard
    private var showCity: Bool = false
    private var showSight: Bool = false
    private var showCountry: Bool = false
    private var timer = Timer()
    private var currentCountry: String = ""
    private var currentCity: String = "Город"
    private var selectMark: Bool = false
    private var selectedFilter: Bool = false
    private var selectMarkFromBottomView: Bool = false
    private var enableMapInteractive: Bool = false
    private var choosenCity: Bool = false
    // название города/деревни когда не определен город
    private var unknownCity = ""
    private var unboardingIsNotPrecees: Bool = false
    // Скрытие всех маркеров когда не зоны города
    private var alreadyIsOutOfBoxCity: Bool = false
    // зум карты
    private var mapZoom: Float = 0
    // показ нижнего скролл из достопримечательностей внизу
    private var showBottomCollectionSight: Bool = true
    // было ли открытие онбординга
    private var openUnboarding: Bool = false
    // тип выбранного фильтра
    private var selectedScrollFilterType: TypeSight?
    // доступные достопримеательности
    private let cities = ["Санкт-Петербург", "Москва", "Екатеринбург", "Казань", "Новосибирск", "Нижний Новгород"]
    
    // MARK: - UI Properties
    
    // Всплывающее вьюха подробней о достопримечательности
    private var floatingView = FloatingView(frame: CGRect(x: 0,
                                                          y: UIScreen.main.bounds.height,
                                                          width: UIScreen.main.bounds.width,
                                                          height: UIScreen.main.bounds.height))
    // Фильтр скролл
    private let topScrollView = ScrollViewOnMap(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: UIScreen.main.bounds.width,
                                                              height: 42))
    // появляющийся поиск сверху
    private let topSearchView = TopSearchView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: UIScreen.main.bounds.width-32,
                                                            height: 60))
    // вьюха погоды
    private var weatherView = WeatherView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: 48,
                                                        height: 40))
    
    // скролл из достопримечательностей внизу
    private let bottomCollectionView = BottomCollectionView(frame: CGRect(x: 0,
                                                                          y: 0,
                                                                          width: UIScreen.main.bounds.width,
                                                                          height: 88))
    
    // вьюха с кнопками "маршрут", "в избранное" и тд
    private let buttonsView = ActionButtonsScrollView(frame: CGRect(x: 0,
                                                                    y: 0,
                                                                    width: UIScreen.main.bounds.width,
                                                                    height: 60))
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupClean()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if openUnboarding {
            setupLocation()
        }
        let showUnboarding = userDefault.bool(forKey: UserDefaults.firstOpenApp)
        if showUnboarding {
            // не в первый раз тогда запускаем поиск локации иначе ошибка треда
            setupLocation()
            interactor?.appendAllMarkers()
        } else {
            // если в первый раз тогда онбординг
            openUnboardingScreen()
        }
        if mapZoom < 9 {
            interactor?.markerWithCountOfCityMarkers()
        }
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupLocation() {
        setupLocationManager()
        // обновление погоды каждые 60 сек
        timer = Timer.scheduledTimer(timeInterval: 60.0,
                                     target: self,
                                     selector: #selector(setupLocationManager),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let cityName = userDefault.string(forKey: UserDefaults.currentCity)
        tabBarController?.tabBar.items?[1].title = cityName
        currentCity = cityName ?? "Город"
        // проверяем было ли нажатие на кнопку "карты" на экране Страны и делаем анимацию камеры и переход на нужные координаты
        
        
        showCity = userDefault.bool(forKey: UserDefaults.showSelectedCity)
        showCountry = userDefault.bool(forKey: UserDefaults.showSelectedCountry)
        showSight = userDefault.bool(forKey: UserDefaults.showSelectedSight)
        
        if showCity {
            let latitude = userDefault.double(forKey: UserDefaults.showSelectedCityWithLatitude)
            let longitude = userDefault.double(forKey: UserDefaults.showSelectedCityWithLongitude)
            animateCameraToPoint(latitude: latitude,
                                 longitude: longitude,
                                 from: .countryViewZoom)
            userDefault.set(false, forKey: UserDefaults.showSelectedCity)
        }
        
        if showCountry {
            let latitude = userDefault.double(forKey: UserDefaults.showSelectedCityWithLatitude)
            let longitude = userDefault.double(forKey: UserDefaults.showSelectedCityWithLongitude)
            animateCameraToPoint(latitude: latitude,
                                 longitude: longitude,
                                 from: .countryView)
            userDefault.set(false, forKey: UserDefaults.showSelectedCountry)
        }
        
        // проверяем было ли нажатие на кнопку "Места" на экране Страны и делаем анимацию камеры и переход на нужные координаты
        
        if showSight {
            userDefault.set(false, forKey: UserDefaults.showSelectedSight)
            guard let name = userDefault.string(forKey: UserDefaults.showSelectedSightName),
                  let marker = interactor?.fetchSelectedSightWithAllMarkers(withName: name) else { return }
            showMarkerSightWithAnimating(marker: marker, showFloatingViewMark: true)
        }
    }
    
    deinit {
        observation?.invalidate()
    }
    
    // MARK: - Helper Functions
    
    private func openUnboardingScreen() {
        let showUnboarding = userDefault.bool(forKey: UserDefaults.firstOpenApp)
        if !showUnboarding {
            openUnboarding = true
            router?.routeToUnboardingVC()
            UserDefaults.standard.setValue(!showUnboarding, forKey: UserDefaults.firstOpenApp)
        }
    }
    
    private func setupUI() {
        let themeName = UserDefaults.standard.string(forKey: UserDefaults.themeAppSelected) ?? "Системная"
        updateSelectedTheme(name: themeName)
        topScrollView.onMapdelegate = self
        topSearchView.alpha = 0
        topSearchView.topSearchDelegate = self
        
        connectivity.connectivityDelegate = self
        
        floatingView.delegate = self
        buttonsView.actionButtonDelegate = self
        bottomCollectionView.delegate = self
        
        mapView.delegate = self
        mapView.settings.compassButton = false
        mapView.settings.myLocationButton = false
        mapView.isMyLocationEnabled = true
        mapView.frame = view.frame
        // убираем с карты все дефолтные метки загрузкой JSON в стиль карты
        mapView.mapStyle = try? GMSMapStyle(jsonString: Constants.mapStyleJSON)
        
        // Определение коректного местоположеня
        observation = mapView.observe(\.myLocation, options: [.new]) { [weak self] mapView, _ in
            self?.location = mapView.myLocation
        }
        
        view.addSubview(mapView)
        view.addSubview(topScrollView)
        view.addSubview(topSearchView)
        view.addSubview(weatherView)
        view.addSubview(floatingView)
        view.addSubview(buttonsView)
        view.addSubview(bottomCollectionView)
        
        topScrollView.anchor(top: view.layoutMarginsGuide.topAnchor,
                             left: view.leftAnchor,
                             bottom: nil,
                             right: view.rightAnchor,
                             paddingTop: 16,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0, height: 65)
        weatherView.anchor(top: topScrollView.bottomAnchor,
                           left: view.leftAnchor,
                           bottom: nil,
                           right: nil,
                           paddingTop: -8,
                           paddingLeft: 16,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 48, height: 40)
        topSearchView.anchor(top: view.layoutMarginsGuide.topAnchor,
                             left: view.leftAnchor,
                             bottom: nil,
                             right: view.rightAnchor,
                             paddingTop: 16,
                             paddingLeft: 16,
                             paddingBottom: 0,
                             paddingRight: 16,
                             width: 0, height: 60)
        buttonsView.anchor(top: nil,
                           left: view.leftAnchor,
                           bottom: view.bottomAnchor,
                           right: view.rightAnchor,
                           paddingTop: 0,
                           paddingLeft: 0,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 0,
                           height: 80)
        bottomCollectionView.anchor(top: nil,
                                    left: view.leftAnchor,
                                    bottom: view.layoutMarginsGuide.bottomAnchor,
                                    right: view.rightAnchor,
                                    paddingTop: 0,
                                    paddingLeft: 0,
                                    paddingBottom: 30,
                                    paddingRight: 0,
                                    width: 0,
                                    height: 88)
        buttonsView.alpha = 0
    }
    
    // Показываем нижнее вью с коллекцией маркеров
    func bottomCollectionViewShow() {
        UIView.animate(withDuration: 0.5) {
            self.bottomCollectionView.alpha = 1
        }
    }
    // Скрываем нижнее вью с коллекцией маркеров
    func bottomCollectionViewhide() {
        UIView.animate(withDuration: 0.5) {
            self.bottomCollectionView.alpha = 0
        }
    }
    
    // сохраняем текущее местоположение в виде Страны и Города
    private func setCurrentLocation(location: CLLocationCoordinate2D, hiden: Bool) {
        let cityLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        cityLocation.fetchCity { [weak self] city, error in
            guard let city = city, error == nil, let self = self else { return }
            let arrLocality = city.components(separatedBy: " ")
            self.unknownCity = city
            if arrLocality.contains("район") {
                self.unknownCity = "Город"
            }
            if arrLocality.contains("деревня") {
                self.unknownCity = arrLocality.last ?? "Город"
            }
            if arrLocality.contains("посёлок") {
                self.unknownCity = arrLocality.last ?? "Город"
            }
        }
        // Первый релиз все по России
        self.userDefault.set("Россия", forKey: UserDefaults.currentLocation)
        var findCity: Bool = false
        for (_,val) in boxCoordinates.enumerated() where
        location.latitude < val.locationTopLeft.latitude &&
        location.latitude > val.locationBottomRight.latitude &&
        location.longitude > val.locationTopLeft.longitude &&
        location.longitude < val.locationBottomRight.longitude {
            self.userDefault.set(val.city, forKey: UserDefaults.currentCity)
            self.tabBarController?.tabBar.items?[1].title = val.city
            self.currentCity = val.city
            if !choosenCity, mapZoom > 9.0 {
                let sight = UserDefaults.standard.getSight()
                let filteredSights = sight.filter( { $0.city == val.city })
                self.bottomCollectionViewhide()
                self.bottomCollectionView.clearModel()
                self.bottomCollectionView.setupModel(model: filteredSights)
                topScrollView.isHidden = false
                weatherView.isHidden = false
                // сюда добавить показ маркеров только для текущего города
                interactor?.showMarkersOnCity(name: val.city)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    self.bottomCollectionView.collectionView.reloadData()
                    if hiden {
                        self.bottomCollectionViewShow()
                    }
                }
                choosenCity = true
                alreadyIsOutOfBoxCity = false
            }
            findCity = true
        }
        if !findCity {
            self.currentCity = unknownCity
            self.userDefault.set(unknownCity, forKey: UserDefaults.currentCity)
            self.tabBarController?.tabBar.items?[1].title = unknownCity
            if !alreadyIsOutOfBoxCity {
                // сюда добавить показ всех маркеров
                if choosenCity {
                    interactor?.markerWithCountOfCityMarkers()
                    choosenCity = false
                }
                // скрываем нижкиюю коллекцию достопримечательностей
                topScrollView.isHidden = true
                weatherView.isHidden = true
                bottomCollectionViewhide()
                tapOnMap()
                showBottomCollectionSight = false
                interactor?.markerWithCountOfCityMarkers()
                alreadyIsOutOfBoxCity = true
            }
        }
    }
    
    private func updateSelectedTheme(name: String) {
        guard #available(iOS 13.0, *) else { return }
        switch name {
        case "Светлая":
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light }
            
        case "Темная":
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark }
            
        default:
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .unspecified }
        }
    }
    
    // Настройка архитектуры Clean Swift
    private func setupClean() {
        let viewController = self
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        let router = MapRouter()
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.mapController = viewController
        router.viewController = viewController
    }
    
    // Настройка locationManager
    @objc private func setupLocationManager() {
        if !selectedFilter && !selectMark {
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    // Начальная функция показа всех тестовых/реальных маркеров в зависимости от оплаты страны
    private func addDefaultMarkers() {
        interactor?.appendAllMarkers()
    }
    
    // Сокрытие поисковой строки и отображение строки с фильтрами
    private func hideTopSearchView() {
        if topSearchView.alpha == 1 {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                UIView.animate(withDuration: 0.25) {
                    self.topSearchView.alpha = 0
                    self.topSearchView.inputTextField.resignFirstResponder()
                } completion: { success in
                    if success {
                        UIView.animate(withDuration: 0.55) {
                            self.topScrollView.alpha = 1
                            self.weatherView.alpha = 1
                            self.topSearchView.inputTextField.text = ""
                        }
                    }
                }
            }
        }
    }
    
    func showAlert(_ message:String) {
        let alert = UIAlertController(title: Constants.Errors.locationError, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.Errors.ok, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Показ строки с фильтрами
    func showScrollAndWeatherView() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.topScrollView.alpha = 1
        }
        showWeatherView()
    }
    
    // анимация камеры на конкретный маркер
    private func animateCameraToPoint(latitude: Double, longitude: Double, from: MapViewZoom) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.75)
        let locationMarketTappedLon = longitude
        let locationMarketTappedLat = latitude
        let location = CLLocationCoordinate2D(latitude: locationMarketTappedLat, longitude: locationMarketTappedLon)
        var zoom: Float = 0
        switch from {
        case .mapViewZoom:
            zoom = self.cameraZoom + 1
        case .countryViewZoom:
            zoom = 10
        case .countryView:
            zoom = 2.65
        }
        let camera = GMSCameraPosition(target: location, zoom: zoom)
        mapView.animate(to: camera)
        CATransaction.commit()
    }
    
    // при отсутствии интернета скрываем погоду
    private func hideWeatherView() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.weatherView.alpha = 0
        }
    }
    
    private func showWeatherView() {
        if !selectedFilter {
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self = self else { return }
                self.weatherView.alpha = 1
            }
        }
    }
    
    private func showMarkerSightWithAnimating(marker: GMSMarker, showFloatingViewMark: Bool) {
        // делаем запрос на данные для floatinView
        if let nameLocation = marker.title {
            let sights = UserDefaults.standard.getSight()
            
            for (_,val) in sights.enumerated() where val.name == nameLocation {
                buttonsView.setupFavoriteName(sight: val)
                interactor?.showCurrentMarker(request: MapViewModel.ChoosenDestinationView.Request(marker: nameLocation))
                animateCameraToPoint(latitude: marker.position.latitude - 0.0036,
                                     longitude: marker.position.longitude,
                                     from: .mapViewZoom)
                floatingView.configureCell(model: val)
                floatingView.showFloatingView()
                selectMark = showFloatingViewMark
            }
            
        }
    }
    
    // Работа маркеров, анимации когда тыкнули нижниюю коллекцию
    private func showSelectMarkerSightWithAnimating(animateMarkers: Bool = true, marker: GMSMarker, showFloatingViewMark: Bool) {
        // делаем запрос на данные для floatinView
        if let nameLocation = marker.title {
            let sights = UserDefaults.standard.getSight()
            if sights.first(where: { $0.name == nameLocation }) != nil {
                if animateMarkers {
                    interactor?.showSelectedMarker(request: MapViewModel.ChoosenDestinationView.Request(
                        marker: nameLocation))
                }
                animateCameraToPoint(latitude: marker.position.latitude - 0.0036,
                                     longitude: marker.position.longitude,
                                     from: .mapViewZoom)
                selectMark = showFloatingViewMark
            }
        }
    }
    
    private func updateBottomCollectionView(zoom: Float) {
        // При приближении и отдалении карты
        if zoom < 9.0 {
            // Скрыаем нижний скролл с достопримечательностями
            if showBottomCollectionSight {
                bottomCollectionViewhide()
                tapOnMap()
                showBottomCollectionSight = false
                topScrollView.isHidden = true
                weatherView.isHidden = true
                topScrollView.updateFilterView()
                interactor?.markerWithCountOfCityMarkers()
            }
        } else {
            // Показываем нижний скролл с достопримечательностями
            if !showBottomCollectionSight {
                if cities.contains(currentCity) {
                    bottomCollectionViewShow()
                    topScrollView.isHidden = false
                    weatherView.isHidden = false
                    interactor?.showMarkersOnCity(name: currentCity)
                }
                showBottomCollectionSight = true
            }
        }
        mapZoom = zoom
    }
    
    private func tapOnMap() {
        hideTopSearchView()
        if enableMapInteractive {
            selectMark = true
            hideTopSearchView()
            floatingView.hideFloatingView()
            showScrollAndWeatherView()
            if selectMark || selectMarkFromBottomView {
                selectMark = false
                selectMarkFromBottomView = false
            }
            enableMapInteractive = false
        }
        
        if let selectedScrollFilterType = selectedScrollFilterType{
            if selectedScrollFilterType == .favorite {
                // Фильтрация по избранным
                interactor?.fetchAllFavorites(selected: true)
            } else {
                interactor?.fetchAllTestMarkers(request: selectedScrollFilterType)
            }
        } else {
            if enableMapInteractive {
                addDefaultMarkers()
            }
        }
    }
}



// MARK: - GMSMapViewDelegate
extension MapController: GMSMapViewDelegate {
    
    // Вызывается при изменении позиции карты
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        // определение текущего местоположения
        cameraLatitude = mapView.camera.target.latitude
        cameraLongitude = mapView.camera.target.longitude
        updateBottomCollectionView(zoom: mapView.camera.zoom)
    }
    
    // вызывается при нажатии на маркер
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        enableMapInteractive = true
        if !selectMark {
            selectMark = true
            // делаем запрос на данные для floatinView
            showMarkerSightWithAnimating(marker: marker, showFloatingViewMark: true)
            return true
        } else {
            return false
        }
    }
    
    // вызывается при нажатии на карту
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        tapOnMap()
    }
    
    // вызывается когда начинается передвижение карты
    //    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
    //        hideTopSearchView()
    //    }
    
    // Вызывается когда камера перестала двигатся
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        updateBottomCollectionView(zoom: mapView.camera.zoom)
        setCurrentLocation(location: position.target, hiden: showBottomCollectionSight)
    }
    
    // Построение маршрута
    func fetchRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let defaultNavi = UserDefaults.standard.string(forKey: UserDefaults.defaultNaviRoute)

        // дефолтный адрес открытия в поисковике гугла
        let firsheaderYandex = URL(string: "yandexnavi://")!
        let firsheaderGoogle = URL(string: "comgooglemaps://")!
        let stringUrlYandex = "yandexnavi://build_route_on_map?lat_to=\(destination.latitude)&lon_to=\(destination.longitude)"
        let stringUrlGoogle = "comgooglemaps://comgooglemaps-x-callback://?saddr=&daddr=\(destination.latitude),\(destination.longitude)&directionsmode=driving"
        let stringUrlWeb = "comgooglemaps://?saddr=&daddr=\(destination.latitude),\(destination.longitude)&directionsmode=driving"
        
        
        switch defaultNavi {
            
            // Яндекс дефолтный
        case "Яндекс":
            if UIApplication.shared.canOpenURL(firsheaderYandex) {
                // open with yandex
                openUrl(urlString: stringUrlYandex)
                
            } else if UIApplication.shared.canOpenURL(firsheaderGoogle) {
                // open with google
                openUrl(urlString: stringUrlGoogle)
                
            } else {
                // open with web
                openUrl(urlString: stringUrlWeb)
            }
            
            // Гугл дефолтный
        case "Google":
            if UIApplication.shared.canOpenURL(firsheaderGoogle) {
                // open with google
                openUrl(urlString: stringUrlGoogle)
                
            } else if UIApplication.shared.canOpenURL(firsheaderYandex) {
                // open with yandex
                openUrl(urlString: stringUrlYandex)
                
            } else {
                // open with web
                openUrl(urlString: stringUrlWeb)
            }
            
            // В любых других случаях открываем с помощью веба
        default:
            // open with web
            openUrl(urlString: stringUrlWeb)
        }
    }
    
    private func openUrl(urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
}

// MARK: - ScrollViewOnMapDelegate
extension MapController: ScrollViewOnMapDelegate {
    
    // Фильтрация маркеров
    func chooseSightSelected(selected: Bool, request: TypeSight) {
        if selectedScrollFilterType == nil {
            selectedScrollFilterType = request
        } else {
            selectedScrollFilterType = nil
        }
        
        if request == .favorite {
            // Фильтрация по избранным
            interactor?.fetchAllFavorites(selected: selected)
        } else {
            selected
            ? interactor?.appendAllMarkers()
            : interactor?.fetchAllTestMarkers(request: request)
        }
        
    }
    
    // Отображение поисковой строки и сокрытие строки с фильтрами
    func showSearchView() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { return }
            self.weatherView.alpha = 0
            self.topScrollView.alpha = 0
        } completion: { success in
            if success {
                UIView.animate(withDuration: 0.55) {
                    self.topSearchView.alpha = 1
                }
            }
        }
    }
}

// MARK: - TopSearchViewDelegate
extension MapController: TopSearchViewDelegate {
    
    // Фильтрация по вводу текста в поиске в самом верху
    func findSight(withCharacter: String) {
        interactor?.searchWithCaracter(character: withCharacter)
    }
    
    // Скрываем поисковую строку и клавиатуру при нажатии на крестик в textField
    func clearTextField() {
        hideTopSearchView()
    }
}

// MARK: - ConnectivityDelegate
extension MapController: ConnectivityDelegate {
    func lostInternetConnection() {
        hideWeatherView()
        internetConnection = false
        let alert = UIAlertController(
            title: Constants.Errors.internetError,
            message: Constants.Errors.turnOnInternet,
            preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Constants.Errors.ok, style: .default))
        alert.addAction(UIAlertAction(title: Constants.Errors.settings, style: .default, handler: {_ in
            if let url = URL.init(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: Constants.Errors.close, style: .cancel))
        present(alert, animated: true)
    }
    
    func goodInternetConnection() {
        locationManager.startUpdatingLocation()
        internetConnection = true
        
    }
}

// MARK: - CLLocationManagerDelegate

extension MapController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            myCurrentLatitude = location.coordinate.latitude
            myCurrentLongitude = location.coordinate.longitude
            cameraLatitude = myCurrentLatitude
            cameraLongitude = myCurrentLongitude
            WeatherAPI().loadCurrentWeather(latitude: myCurrentLatitude,
                                            longitude: myCurrentLongitude) { temp, image in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    UIView.animate(withDuration: 0.5) {
                        // При открытом поиске не показываем вьюху погоды
                        if self.selectedFilter {
                            self.weatherView.alpha = 1
                        }
                        self.weatherView.weatherViewTemperature = temp
                        self.weatherView.weatherViewImage = image
                    }
                }
            }
            manager.stopUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                if #available(iOS 14.0, *) {
                    switch(self.locationManager.authorizationStatus) {
                    case .notDetermined, .restricted, .denied:
                        self.showAlert(Constants.Errors.allowLocationPermision)
                        self.hideWeatherView()
                    case .authorizedAlways, .authorizedWhenInUse:
                        break
                    @unknown default:
                        break
                    }
                } else {
                    switch(CLLocationManager.authorizationStatus()) {
                    case .notDetermined, .restricted, .denied:
                        self.showAlert(Constants.Errors.allowLocationPermision)
                        self.hideWeatherView()
                    case .authorizedAlways, .authorizedWhenInUse:
                        break
                    @unknown default:
                        break
                    }
                }
            } else {
                self.showAlert(Constants.Errors.allowLocationOnDevice)
                self.hideWeatherView()
            }
            manager.stopUpdatingLocation()
        }
    }
}

// MARK: - FloatingViewDelegate
extension MapController: FloatingViewDelegate {
    
    func makeCall(withNumber: String) {
        callButtonTapped(withNumber: withNumber)
    }
    
    func addToFavorite(name: String) {
        interactor?.updateFavorites(name: name)
    }
    
    func routeTo(location: CLLocationCoordinate2D) {
        routeButtonTapped(location: location)
    }
    
    
    // Открываем сайт/соц сеть или др достопримечательности из всплывающей подробностей
    func openUrl(name: String) {
        guard let openUrl = URL(string: name) else { return }
        UIApplication.shared.open(openUrl)
    }
    
    func floatingPanelFullScreen() {
        bottomCollectionViewhide()
        buttonsView.alpha = 1
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.buttonsView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
    }
    
    func floatingPanelPatriallyScreen() {
        bottomCollectionViewhide()
        let originYButtonsView = buttonsView.frame.origin.y
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.buttonsView.frame.origin.y = UIScreen.main.bounds.height
            self.buttonsView.alpha = 0
        } completion: { success in
            if success {
                self.buttonsView.frame.origin.y = originYButtonsView
                UIView.animate(withDuration: 0.5) {
                    self.buttonsView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
                }
            }
        }
    }
    
    func floatingPanelIsHidden() {
        bottomCollectionViewShow()
        UIView.animate(withDuration: 0.35) { [weak self] in
            guard let self = self else { return }
            self.tabBarController?.tabBar.alpha = 1
            self.buttonsView.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.buttonsView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
        }
        mapView.settings.myLocationButton = true
        showScrollAndWeatherView()
        if selectMark {
            selectMark = false
        }
        
        if let selectedScrollFilterType = selectedScrollFilterType {
            if selectedScrollFilterType == .favorite {
                // Фильтрация по избранным
                interactor?.fetchAllFavorites(selected: true)
            } else {
                // Фильтрация
                interactor?.fetchAllTestMarkers(request: selectedScrollFilterType)
            }
        } else {
            // показ всех маркеров
            addDefaultMarkers()
        }
    }
}

// MARK: - ActionButtonsScrollViewDelegate

extension MapController: ActionButtonsScrollViewDelegate {
    
    // Вызов номера из меню в низу во всплывающей вьюхе
    func callButtonTapped(withNumber: String) {
        var uc = URLComponents()
        uc.scheme = "tel"
        uc.path = withNumber
        if let phoneURL = uc.url {
            let application = UIApplication.shared
            if application.canOpenURL(phoneURL) {
                application.open(phoneURL, options: [:], completionHandler: nil)
            } else {
                debugPrint("[DEBUGSSS]: \(#function) Ошибка: не возможно сделать вызов на устройстве")
            }
        }
    }
    
    // Открыть Url сайт/соц сеть или др из меню в низу во всплывающей вьюхе
    func siteButtonTapped(urlString: String) {
        openUrl(name: urlString)
    }
    
    // из меню в низу во всплывающей вьюхе
    func routeButtonTapped(location: CLLocationCoordinate2D) {
        let fromCurrentLocation = CLLocationCoordinate2D(latitude: cameraLatitude,
                                                         longitude: cameraLongitude)
        fetchRoute(from: fromCurrentLocation, to: location)
    }
    
    
    // Добавление или удаление избранного из меню в низу во всплывающей вьюхе
    func addToFavouritesButtonTapped(name: String) {
        interactor?.updateFavorites(name: name)
    }
}

// MARK: - MapDisplayLogic

extension MapController: MapDisplayLogic {
    
    // Показ маркеров над городами с количеством достопримечательностей
    func displayEmptyMarkers(markers: [GMSMarker]) {
        DispatchQueue.main.async {
            self.mapView.clear()
            markers.forEach {
                $0.map = self.mapView
            }
        }
    }
    
    // Отображаем маркеры при вводе текста из поиска в ScrollView (TopViewSearch)
    func displayFetchedMarkersFromSearchView(withString: String) {
        print("displayFetchedMarkersFromSearchView:\(withString)")
    }
    
    // Отображаем маркеры при нажатии на фильтры в ScrollView
    func displayMarkers(filter: [GMSMarker]) {
        DispatchQueue.main.async {
            self.mapView.clear()
            filter.forEach {
                $0.map = self.mapView
            }
        }
        let sight = UserDefaults.standard.getSight()
        let cityName = userDefault.string(forKey: UserDefaults.currentCity)
        if cityName == "Город" || cityName == "" || cityName == nil {
            bottomCollectionView.setupModel(model: sight)
        } else {
            bottomCollectionView.setupModel(model: sight.filter( { $0.city == cityName }))
        }
        DispatchQueue.main.async {
            self.bottomCollectionView.collectionView.reloadData()
        }
    }
    
    // при нажатии на маркер на экране
    // заполнение floating view данными из текущей модели viewModel
    func displayChoosenDestination(viewModel: MapViewModel.ChoosenDestinationView.ViewModel, selectedSight: Sight) {
        // всю эту логику перенести в метод от презентера - показ FloatingView конкретной меткой и данными по ней.
        
        mapView.clear()
        viewModel.markers.forEach {
            $0.map = mapView
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.35) {
                self.tabBarController?.tabBar.alpha = 0
                self.mapView.settings.myLocationButton = false
            }
            UIView.animate(withDuration: 0.5) {
                self.bottomCollectionView.alpha = 0
                self.topScrollView.alpha = 0
                self.weatherView.alpha = 0
                self.topSearchView.alpha = 0
                self.topSearchView.inputTextField.resignFirstResponder()
            }
        }
    }
    
    // при нажатии на ячейку на collection bottom view на экране
    func displaySelectedDestination(viewModel: MapViewModel.ChoosenDestinationView.ViewModel) {
        mapView.clear()
        viewModel.markers.forEach {
            $0.map = mapView
        }
    }
    
}

// MARK: - CurrentCityButtonViewDelegate

extension MapController: CurrentCityButtonViewDelegate {
    
    func showCurrentCityViewController() {
        router?.routeToCityVC()
    }
}

// MARK: - BottomCollectionViewDelegate

extension MapController: BottomCollectionViewDelegate {
    
    // Выбор достопримечательности из скролл коллекции снизу экрана
    func showSight(nameSight: String) {
        print("nameSightnameSight:\(nameSight)")
        
        guard let marker = interactor?.fetchSelectedSightWithAllMarkers(withName: nameSight) else { return }
        print("marker:\(marker)")
        enableMapInteractive = true
        if !selectMark {
            selectMark = true
            // делаем запрос на данные для floatinView
            showMarkerSightWithAnimating(marker: marker, showFloatingViewMark: true)
        }
    }
    
}
