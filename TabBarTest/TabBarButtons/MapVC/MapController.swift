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
    func displayChoosenDestination(viewModel: MapViewModel.ChoosenDestinationView.ViewModel)
    func displayMarkers(filter: [GMSMarker])
    func displayFetchedMarkersFromSearchView(withString: String)
}



class MapController: UIViewController {
    
    enum MapViewZoom {
        case mapViewZoom
        case countryViewZoom
    }
    
    // MARK: - Public Properties
    
    var interactor: MapBussinessLogic?
    var router: (NSObjectProtocol & MapRoutingLogic)?
    var citiesAvailable = ["Москва","Санкт-Петербург","Сочи","Краснодар","Гатчина","Cupertino"]
    
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
    private var show: Bool = false
    private var timer = Timer()
    private var currentCountry: String = ""
    private var selectMark: Bool = false
    private var selectedFilter: Bool = false
    
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
                                                            width: UIScreen.main.bounds.width-20,
                                                            height: 60))
    private var weatherView = WeatherView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: 50,
                                                        height: 38))
    private let buttonsView = ActionButtonsScrollView(frame: CGRect(x: 0,
                                                                    y: 0,
                                                                    width: UIScreen.main.bounds.width,
                                                                    height: 60))
    //    private let showCurrentCityView = CurrentCityButtonView(frame: CGRect(x: 0,
    //                                                                          y: 0,
    //                                                                          width: 60,
    //                                                                          height: 60))
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupClean()
        setupUI()
        // вызываем только 1 раз для заполнения массива маркерами
        interactor?.appendAllMarkers()
        addDefaultMarkers()
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
        
        // проверяем было ли нажатие на кнопку карты на экране Страны и делаем анимацию камеры и переход на нужные координаты
        show = userDefault.bool(forKey: UserDefaults.showSelectedCity)
        if show {
            let latitude = userDefault.double(forKey: UserDefaults.showSelectedCityWithLatitude)
            let longitude = userDefault.double(forKey: UserDefaults.showSelectedCityWithLongitude)
            animateCameraToPoint(latitude: latitude,
                                 longitude: longitude,
                                 from: .countryViewZoom)
            userDefault.set(false, forKey: UserDefaults.showSelectedCity)
        }
        
        // проверяем было ли нажатие на кнопку Места на экране Страны и делаем анимацию камеры и переход на нужные координаты
        show = userDefault.bool(forKey: UserDefaults.showSelectedSight)
        if show {
            userDefault.set(false, forKey: UserDefaults.showSelectedSight)
            guard let name = userDefault.string(forKey: UserDefaults.showSelectedSightName),
                  let marker = interactor?.fetchSelectedSightWithAllMarkers(withName: name) else { return }
            showMarkerSightWithAnimating(marker: marker)
        }
    }
    
    deinit {
        observation?.invalidate()
    }
    
    // MARK: - Helper Functions
    
    private func setupUI() {
        
        
        
        topScrollView.onMapdelegate = self
        topSearchView.alpha = 0
        topSearchView.topSearchDelegate = self
        
        connectivity.connectivityDelegate = self
        
        floatingView.delegate = self
        buttonsView.actionButtonDelegate = self
        
        //        showCurrentCityView.delegate = self
        
        mapView.delegate = self
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
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
        //        view.addSubview(showCurrentCityView)
        
        topScrollView.anchor(top: view.layoutMarginsGuide.topAnchor,
                             left: view.leftAnchor,
                             bottom: nil,
                             right: view.rightAnchor,
                             paddingTop: 15,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0, height: 65)
        weatherView.anchor(top: topScrollView.bottomAnchor,
                           left: view.leftAnchor,
                           bottom: nil,
                           right: nil,
                           paddingTop: 0,
                           paddingLeft: 15,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 50, height: 38)
        topSearchView.anchor(top: view.layoutMarginsGuide.topAnchor,
                             left: view.leftAnchor,
                             bottom: nil,
                             right: view.rightAnchor,
                             paddingTop: 15,
                             paddingLeft: 10,
                             paddingBottom: 0,
                             paddingRight: 10,
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
        //        showCurrentCityView.anchor(top: topScrollView.bottomAnchor,
        //                                   left: nil,
        //                                   bottom: nil,
        //                                   right: view.rightAnchor,
        //                                   paddingTop: 0,
        //                                   paddingLeft: 0,
        //                                   paddingBottom: 0,
        //                                   paddingRight: 15,
        //                                   width: 60,
        //                                   height: 60)
        buttonsView.alpha = 0
    }
    
    // сохраняем текущее местоположение в виде Страны и Города
    private func setCurrentLocation() {
        let location = CLLocation(latitude: cameraLatitude, longitude: cameraLongitude)
        location.fetchCityAndCountry { [weak self] (city, country, error) in
            guard let self = self,
                  let city = city,
                  let country = country,
                  error == nil
            //                  ,self.tabBarController?.tabBar.items?[1].title != country
            else { return }
            self.userDefault.set("\(country)", forKey: UserDefaults.currentLocation)
            // MARK: - TODO - сделать сравнение текущего города если в структуре у этого города есть метки тогда отображаем кнопку на карте - переход на достопримечательности текущего города, если нету меток тогда не записываем в юзер дефолт и не показываем кнопку перехода.
            self.citiesAvailable.forEach {
                if $0 == city {
                    self.userDefault.set("\(city)", forKey: UserDefaults.currentCity)
                }
            }
            self.tabBarController?.tabBar.items?[1].title = country
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
        let request = MapViewModel.FilterName.Alltest
        interactor?.fetchAllTestMarkers(request: request)
    }
    
    // Сокрытие поисковой строки и отображение строки с фильтрами
    private func hideTopSearchView() {
        if topSearchView.alpha == 1 {
            DispatchQueue.main.async {
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
        UIView.animate(withDuration: 0.5) {
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
        }
        let camera = GMSCameraPosition(target: location, zoom: zoom)
        mapView.animate(to: camera)
        CATransaction.commit()
    }
    
    // при отсутствии интернета скрываем погоду
    private func hideWeatherView() {
        UIView.animate(withDuration: 0.5) {
            self.weatherView.alpha = 0
        }
    }
    
    private func showWeatherView() {
        if !selectedFilter {
            UIView.animate(withDuration: 0.5) {
                self.weatherView.alpha = 1
            }
        }
    }
    
    private func showMarkerSightWithAnimating(marker: GMSMarker) {
        // делаем запрос на данные для floatinView
        if let nameLocation = marker.title {
            interactor?.showCurrentMarker(request: MapViewModel.ChoosenDestinationView.Request(marker: nameLocation))
            animateCameraToPoint(latitude: marker.position.latitude - 0.0036,
                                 longitude: marker.position.longitude,
                                 from: .mapViewZoom)
            selectMark = true
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
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        
        let alert = UIAlertController(
            title: "Location Tapped",
            message: "Current location: <\(location.latitude), \(location.longitude)>",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // вызывается при нажатии на маркер
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        // делаем запрос на данные для floatinView
        showMarkerSightWithAnimating(marker: marker)
        return true
    }
    
    // вызывается при нажатии на карту
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        hideTopSearchView()
        floatingView.hideFloatingView()
        showScrollAndWeatherView()
        if selectMark {
            addDefaultMarkers()
            selectMark = false
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
    
    // Фильтрация маркеров по музею
    func chooseSightFilter(completion: @escaping () -> (Bool)) {
        var request: MapViewModel.FilterName
        if completion() {
            request = MapViewModel.FilterName.Museum
            selectedFilter = true
            hideWeatherView()
        } else {
            request = MapViewModel.FilterName.Alltest
            selectedFilter = false
            showWeatherView()
        }
        interactor?.fetchAllTestMarkers(request: request)
    }
    
    // Фильтрация маркеров по парку
    func chooseParkFilter() {
        let request = MapViewModel.FilterName.Park
        interactor?.fetchAllTestMarkers(request: request)
    }
    
    // Фильтрация маркеров по достопримечательностям
    func choosePoiFilter() {
        let request = MapViewModel.FilterName.POI
        interactor?.fetchAllTestMarkers(request: request)
    }
    
    // Фильтрация маркеров по пляжам
    func chooseBeachFilter() {
        let request = MapViewModel.FilterName.Beach
        interactor?.fetchAllTestMarkers(request: request)
    }
    
    // Отображение поисковой строки и сокрытие строки с фильтрами
    func showSearchView() {
        UIView.animate(withDuration: 0.25) {
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
                
                DispatchQueue.main.async {
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
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                showAlert(Constants.Errors.allowLocationPermision)
                hideWeatherView()
            case .authorizedAlways, .authorizedWhenInUse:
                break
            @unknown default:
                break
            }
        } else {
            showAlert(Constants.Errors.allowLocationOnDevice)
            hideWeatherView()
        }
        manager.stopUpdatingLocation()
    }
}

// MARK: - FloatingViewDelegate
extension MapController: FloatingViewDelegate {
    func floatingPanelFullScreen() {
        buttonsView.alpha = 1
        UIView.animate(withDuration: 0.5) {
            self.buttonsView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
    }
    
    func floatingPanelPatriallyScreen() {
        let originYButtonsView = buttonsView.frame.origin.y
        UIView.animate(withDuration: 0.3) {
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
        UIView.animate(withDuration: 0.35) {
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
    func siteButtonTapped() {
        print("Открытие сайта если он есть")
    }
    
    func routeButtonTapped() {
        print("Постоение маршрута")
    }
    
    func addToFavouritesButtonTapped() {
        print("Добавление в избранное")
    }
    
    func callButtonTapped() {
        print("Позвонить")
    }
    
    func shareButtonTapped() {
        print("Поделиться - ActionView")
    }
}

// MARK: - MapDisplayLogic
extension MapController: MapDisplayLogic {
    // Отображаем маркеры при вводе текста из поиска в ScrollView (TopViewSearch)
    func displayFetchedMarkersFromSearchView(withString: String) {
        print(#function)
    }
    
    // Отображаем маркеры при нажатии на фильтры в ScrollView
    func displayMarkers(filter: [GMSMarker]) {
        mapView.clear()
        filter.forEach {
            $0.map = mapView
        }
    }
    
    func displayAllReleaseMarkers(filler: MapViewModel.FilterName) {
        print(#function)
    }
    
    // при нажатии на маркер на экране
    // заполнение floating view данными из текущей модели viewModel
    func displayChoosenDestination(viewModel: MapViewModel.ChoosenDestinationView.ViewModel) {
        // всю эту логику перенести в метод от презентера - показ FloatingView конкретной меткой и данными по ней.
        
        mapView.clear()
        viewModel.markers.forEach {
            $0.map = mapView
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.35) {
                self.tabBarController?.tabBar.alpha = 0
                self.mapView.settings.myLocationButton = false
            } completion: { _ in
                self.floatingView.showFloatingView()
            }
            UIView.animate(withDuration: 0.5) {
                self.topScrollView.alpha = 0
                self.weatherView.alpha = 0
            }
        }
    }
}

// MARK: - CurrentCityButtonViewDelegate

extension MapController: CurrentCityButtonViewDelegate {
    func showCurrentCityViewController() {
        router?.routeToCityVC()
    }
}
