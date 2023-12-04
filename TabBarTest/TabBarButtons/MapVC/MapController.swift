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
    var citiesAvailable = ["Москва", "Санкт-Петербург", "Екатеринбург", "Казань"]
    
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
    private var selectMark: Bool = false
    private var selectedFilter: Bool = false
    private var selectMarkFromBottomView: Bool = false
    private var enableMapInteractive: Bool = false
    
    // MARK: - UI Properties
    
    private var floatingView = FloatingView(frame: CGRect(x: 0,
                                                          y: UIScreen.main.bounds.height,
                                                          width: UIScreen.main.bounds.width,
                                                          height: UIScreen.main.bounds.height))
    private let topScrollView = ScrollViewOnMap(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: UIScreen.main.bounds.width,
                                                              height: 42))
    private let topSearchView = TopSearchView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: UIScreen.main.bounds.width-32,
                                                            height: 60))
    private var weatherView = WeatherView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: 48,
                                                        height: 40))
    private let buttonsView = ActionButtonsScrollView(frame: CGRect(x: 0,
                                                                    y: 0,
                                                                    width: UIScreen.main.bounds.width,
                                                                    height: 60))
    private let bottomCollectionView = BottomCollectionView(frame: CGRect(x: 0,
                                                                          y: 0,
                                                                          width: UIScreen.main.bounds.width,
                                                                          height: 88))
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupClean()
        setupUI()
        // вызываем только 1 раз для заполнения массива маркерами
        setupLang()
        interactor?.appendAllMarkers()
        setupLocationManager()
        // обновление погоды каждые 60 сек
        timer = Timer.scheduledTimer(timeInterval: 60.0,
                                     target: self,
                                     selector: #selector(setupLocationManager),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    
    // Определение текущего языка приложения
    private func setupLang() {
        let langStr = Locale.current.languageCode
        userDefault.set(langStr, forKey: UserDefaults.currentLang)
    }
    
    private func setupUI() {
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
        bottomCollectionView.alpha = 0
    }
    
    // сохраняем текущее местоположение в виде Страны и Города
    private func setCurrentLocation() {
        let location = CLLocation(latitude: cameraLatitude, longitude: cameraLongitude)
        location.fetchCityAndCountry { [weak self] (city, country, error) in
            guard let self = self,
                  let city = city,
                  let country = country,
                  error == nil
            else { return }
            self.userDefault.set("\(country)", forKey: UserDefaults.currentLocation)
            // MARK: - TODO - сделать сравнение текущего города если в структуре у этого города есть метки тогда отображаем кнопку на карте - переход на достопримечательности текущего города, если нету меток тогда не записываем в юзер дефолт и не показываем кнопку перехода.
            self.citiesAvailable.forEach {
                if $0 == city {
                    self.userDefault.set("\(city)", forKey: UserDefaults.currentCity)
                    self.tabBarController?.tabBar.items?[1].title = city
                }
            }
            
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
            zoom = 5
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
            let currentSight = sights.first(where: { $0.name == nameLocation })
            buttonsView.setupFavoriteName(name: nameLocation,
                                          phone: currentSight?.main_phone ?? "",
                                          url: currentSight?.site ?? "")
            interactor?.showCurrentMarker(request: MapViewModel.ChoosenDestinationView.Request(marker: nameLocation))
            animateCameraToPoint(latitude: marker.position.latitude - 0.0036,
                                 longitude: marker.position.longitude,
                                 from: .mapViewZoom)
            selectMark = showFloatingViewMark
        }
    }
    
    // Работа маркеров, анимации когда тыкнули нижниюю коллекцию
    private func showSelectMarkerSightWithAnimating(animateMarkers: Bool = true, marker: GMSMarker, showFloatingViewMark: Bool) {
        // делаем запрос на данные для floatinView
        if let nameLocation = marker.title {
            let sights = UserDefaults.standard.getSight()
            let currentSight = sights.first(where: { $0.name == nameLocation })
            if animateMarkers {
                buttonsView.setupFavoriteName(name: nameLocation,
                                              phone: currentSight?.main_phone ?? "",
                                              url: currentSight?.site ?? "")
                interactor?.showSelectedMarker(request: MapViewModel.ChoosenDestinationView.Request(marker: nameLocation))
            }
            animateCameraToPoint(latitude: marker.position.latitude - 0.0036,
                                 longitude: marker.position.longitude,
                                 from: .mapViewZoom)
            selectMark = showFloatingViewMark
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
    }
    
    // Вызывается по нажатию на свое местоположение
    // MARK: - TODO УДАЛИТЬ
//    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
//        
//        let alert = UIAlertController(
//            title: "Location Tapped",
//            message: "Current location: <\(location.latitude), \(location.longitude)>",
//            preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true)
//    }
    
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
        if enableMapInteractive {
            selectMark = true
            hideTopSearchView()
            floatingView.hideFloatingView()
            showScrollAndWeatherView()
            if selectMark || selectMarkFromBottomView {
                addDefaultMarkers()
                selectMark = false
                selectMarkFromBottomView = false
            }
            enableMapInteractive = false
        }
    }
    
    // вызывается когда начинается передвижение карты
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        hideTopSearchView()
        
    }
    // Вызывается когда камера перестала двигатся
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        setCurrentLocation()
    }
}

// MARK: - ScrollViewOnMapDelegate
extension MapController: ScrollViewOnMapDelegate {
    
    // Фильтрация маркеров по достопримечательности
    func chooseSight() {
        interactor?.fetchAllTestMarkers(request: .sightSeen)
    }
    
    // Фильтрация маркеров по музеям
    func chooseMuseum() {
        interactor?.fetchAllTestMarkers(request: .museum)
    }
    
    // Фильтрация маркеров по культурным объектам
    func chooseCultureObject() {
        interactor?.fetchAllTestMarkers(request: .cultureObject)
    }
    
    // Фильтрация маркеров по Богослужению
    func chooseGod() {
        interactor?.fetchAllTestMarkers(request: .god)
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
                        self.weatherView.alpha = 1
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
    
    // Делаем вызов номера телефона достопримечательности из всплывающей подробностей
    func makeCall(withNumber: String) {
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
        if selectMark {
            addDefaultMarkers()
            selectMark = false
        }
        mapView.settings.myLocationButton = true
        showScrollAndWeatherView()
    }
}

// MARK: - ActionButtonsScrollViewDelegate

extension MapController: ActionButtonsScrollViewDelegate {
    
    // Вызов номера из меню в низу во всплывающей вьюхе
    func callButtonTapped(withNumber: String) {
        makeCall(withNumber: withNumber)
    }
    
    // Открыть Url сайт/соц сеть или др из меню в низу во всплывающей вьюхе
    func siteButtonTapped(urlString: String) {
        openUrl(name: urlString)
    }
    
    // из меню в низу во всплывающей вьюхе
    func routeButtonTapped() {
        print("Постоение маршрута")
    }
    
    // Добавление или удаление избранного из меню в низу во всплывающей вьюхе
    func addToFavouritesButtonTapped(name: String) {
        interactor?.updateFavorites(name: name)
    }
    
    // из меню в низу во всплывающей вьюхе
    func shareButtonTapped() {
        let firstActivityItem = "Пригласить друзей"
        let secondActivityItem = Constants.shareLink
        let image: UIImage = UIImage(named: "AppIcon") ?? UIImage()
        let activityViewController: UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
        activityViewController.activityItemsConfiguration = [UIActivity.ActivityType.message] as? UIActivityItemsConfigurationReading
        
        // Убираем не нужные кнопки
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.dismiss(animated: true)
            }
        }
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - MapDisplayLogic

extension MapController: MapDisplayLogic {
    
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
        bottomCollectionView.setupModel(model: sight)
        DispatchQueue.main.async {
            self.bottomCollectionView.collectionView.reloadData()
        }
    }
    
    func displayAllReleaseMarkers(filler: TypeSight) {
        print("displayAllReleaseMarkers:\(filler)")
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
            } completion: { _ in
                self.floatingView.configureCell(model: selectedSight)
                self.floatingView.showFloatingView()
            }
            UIView.animate(withDuration: 0.5) {
                self.bottomCollectionView.alpha = 0
                self.topScrollView.alpha = 0
                self.weatherView.alpha = 0
                self.topSearchView.alpha = 0
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
        selectMark = false
        selectMarkFromBottomView = true
        guard let marker = interactor?.fetchSelectedSightWithAllMarkers(withName: nameSight) else { return }
        showSelectMarkerSightWithAnimating(animateMarkers: false, marker: marker, showFloatingViewMark: false)
    }
    
}
