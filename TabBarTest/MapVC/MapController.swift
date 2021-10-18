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
    
    // MARK: - Public Properties
    
    var interactor: MapBussinessLogic?
    
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
        let camera = GMSCameraPosition(
            latitude: myCurrentLatitude, longitude: myCurrentLongitude, zoom: cameraZoom)
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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupClean()
        setupUI()
        addDefaultMarkers()
        setupLocationManager()
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
                            right: view.rightAnchor,
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
    }
    
    // Настройка архитектуры Clean Swift
    private func setupClean() {
        let viewController = self
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.mapController = viewController
    }
    
    // Настройка locationManager
    private func setupLocationManager() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
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
        let alert = UIAlertController(title: "Location Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Показ строки с фильтрами
    func showScrollAndWeatherView() {
        UIView.animate(withDuration: 0.5) {
            self.topScrollView.alpha = 1
            self.weatherView.alpha = 1
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
    
    // Вызывается по нажатию на карту
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

            CATransaction.begin()
            CATransaction.setAnimationDuration(0.75)
            let locationMarketTappedLon = marker.position.longitude
            let locationMarketTappedLat = marker.position.latitude - 0.0036
            let location = CLLocationCoordinate2D(latitude: locationMarketTappedLat, longitude: locationMarketTappedLon)
            let camera = GMSCameraPosition(target: location, zoom: self.cameraZoom + 1)
            mapView.animate(to: camera)
            CATransaction.commit()
        }
        return true
    }
    
    
    // вызывается при нажатии карту
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        //        проходимся по всем маркерам
        //        for i in viewModel.allMarkers {
        //            i.icon = GMSMarker.markerImage(with: .black)
        //        }
        hideTopSearchView()
        floatingView.hideFloatingView()
        showScrollAndWeatherView()
        let location = CLLocation(latitude: cameraLatitude, longitude: cameraLongitude)
        location.fetchCityAndCountry { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            print(city + ", " + country)
        }
        
    }
    
    // вызывается когда начинается передвижение карты
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        hideTopSearchView()
        print("\(gesture)")
        
    }
}

// MARK: - ScrollViewOnMapDelegate
extension MapController: ScrollViewOnMapDelegate {
    
    // Фильтрация маркеров по музею
    func chooseMuseumFilter(completion: @escaping () -> (Bool)) {
        var request: MapViewModel.FilterName
        if completion() {
            request = MapViewModel.FilterName.Museum
        } else {
            request = MapViewModel.FilterName.Alltest
        }
        print(completion())
        print(request)
        interactor?.fetchAllTestMarkers(request: request)
    }
    
    // Фильтрация маркеров по парку
    func chooseParkFilter() {
        print("Park filter")
        let request = MapViewModel.FilterName.Park
        interactor?.fetchAllTestMarkers(request: request)
    }
    
    // Фильтрация маркеров по достопримечательностям
    func choosePoiFilter() {
        print("Poi filter")
        let request = MapViewModel.FilterName.POI
        interactor?.fetchAllTestMarkers(request: request)
    }
    
    // Фильтрация маркеров по пляжам
    func chooseBeachFilter() {
        print("Beach filter")
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
        internetConnection = false
        let alert = UIAlertController(
            title: "Ошибка интернета",
            message: "Включите интернет",
            preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        alert.addAction(UIAlertAction(title: "Настройки", style: .default, handler: {_ in
            if let url = URL.init(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
        present(alert, animated: true)
    }
    
    func goodInternetConnection() {
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
                    self.weatherView.weatherViewTemperature = temp
                    self.weatherView.weatherViewImage = image
                }
            }
            manager.stopUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                showAlert("Please Allow the Location Permision to get weather of your city")
            case .authorizedAlways, .authorizedWhenInUse:
                print("locationEnabled")
            @unknown default:
                break
            }
        } else {
            showAlert("Please Turn ON the location services on your device")
            print("locationDisabled")
        }
        manager.stopUpdatingLocation()
    }
}

// MARK: - FloatingViewDelegate
extension MapController: FloatingViewDelegate {
    func floatingPanelIsHidden() {
        UIView.animate(withDuration: 0.35) {
            self.tabBarController?.tabBar.alpha = 1
        }
        self.mapView.settings.myLocationButton = true
        showScrollAndWeatherView()
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
        print(#function)
        print("\(viewModel.destinationName)")
    }
}
