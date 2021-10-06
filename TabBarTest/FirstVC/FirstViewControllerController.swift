//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit
import GoogleMaps
import CoreLocation

protocol FirstViewDisplayLogic: AnyObject {
    func displayChoosenDestination(viewModel: MapViewModel.ChoosenDestinationView.ViewModel)
    func displayMarkers(filter: [GMSMarker])
    func displayFetchedMarkersFromSearchView(withString: String)
}

class FirstViewControllerController: UIViewController, FirstViewDisplayLogic {
    func displayFetchedMarkersFromSearchView(withString: String) {
        print(#function)
    }
    
    func displayMarkers(filter: [GMSMarker]) {
        mapView.clear()
        filter.forEach {
            $0.map = mapView
        }
        print("museum display")
    }
    
    func displayAllReleaseMarkers(filler: MapViewModel.FilterName) {
        print(#function)
    }
    
    func displayChoosenDestination(viewModel: MapViewModel.ChoosenDestinationView.ViewModel) {
        // при нажатии на маркер на экране
        // заполнение floating view данными из текущей модели viewModel
        print(#function)
        print("\(viewModel.destinationName)")
    }
    
    
    var interactor: FirstViewBussinessLogic?
    
    private var myCurrentLatitude: CLLocationDegrees = 0.0
    private var myCurrentLongitude: CLLocationDegrees = 0.0
    private var cameraLatitude: CLLocationDegrees = 0.0
    private var cameraLongitude: CLLocationDegrees = 0.0
    private let cameraZoom: Float = 12
    private let connectivity = Connectivity.shared
    private var internetConnection: Bool = false
    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition(
            latitude: myCurrentLatitude, longitude: myCurrentLongitude, zoom: cameraZoom)
        return GMSMapView(frame: .zero, camera: camera)
    }()
    
    var observation: NSKeyValueObservation?
    var location: CLLocation? {
        didSet {
            guard oldValue == nil, let firstLocation = location else { return }
            mapView.camera = GMSCameraPosition(target: firstLocation.coordinate, zoom: 14)
        }
    }
    // для погоды
    var units = "metric"
    var unit = "°"
    var locationManager = CLLocationManager()
    
    // убираем с карты все дефолтные метки
    
    var floatingView = FloatingView(frame: CGRect(x: 0,
                                                  y: UIScreen.main.bounds.height,
                                                  width: UIScreen.main.bounds.width,
                                                  height: UIScreen.main.bounds.height))
    private let topScrollView = ScrollViewOnMap(frame: CGRect(x: 0,
                                                              y: 65,
                                                              width: UIScreen.main.bounds.width,
                                                              height: 42))
    private let topSearchView = TopSearchView(frame: CGRect(x: 10,
                                                            y: 65,
                                                    width: UIScreen.main.bounds.width-20,
                                                    height: 60))
    private var weatherView = WeatherView(frame: CGRect(x: 10,
                                                        y: 127,
                                                        width: 50,
                                                        height: 38))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupClean()
        
        topScrollView.onMapdelegate = self
        topSearchView.alpha = 0
        topSearchView.topSearchDelegate = self
        
        connectivity.connectivityDelegate = self
        
        floatingView.delegate = self
        
        mapView.delegate = self
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true

        // убираем с карты все дефолтные метки загрузкой JSON в стиль карты
        mapView.mapStyle = try? GMSMapStyle(jsonString: Constants.mapStyleJSON)
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        // Listen to the myLocation property of GMSMapView.
        
        observation = mapView.observe(\.myLocation, options: [.new]) {
            [weak self] mapView, _ in
            self?.location = mapView.myLocation
        }
        view.addSubview(topScrollView)
        view.addSubview(topSearchView)
        view.addSubview(weatherView)
        view.addSubview(floatingView)
        addDefaultMarkers()
        setupLocationManager()
    }
    
    deinit {
        observation?.invalidate()
    }
    
    private func setupClean() {
        let viewController = self
        let interactor = FirstViewControllerInteractor()
        let presenter = FirstViewControllerPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.firstViewController = viewController
    }
    
    func setupLocationManager() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
    
    private func addDefaultMarkers() {
        let request = MapViewModel.FilterName.Alltest
        interactor?.fetchAllTestMarkers(request: request)
    }
    
    private func hideTopSearchView() {
        if topSearchView.alpha == 1 {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.45) {
                    self.topSearchView.alpha = 0
                    self.topSearchView.inputTextField.resignFirstResponder()
                } completion: { success in
                    if success {
                        UIView.animate(withDuration: 0.25) {
                            self.topScrollView.frame.origin.y = 65
                            self.weatherView.alpha = 1
                            self.topSearchView.inputTextField.text = ""
                        }
                    }
                }
                
            }
        }
    }
    
    func loadCurrentWeather() {
        let url = "\(Constants.BASEURL)lat=\(myCurrentLatitude)&lon=\(myCurrentLongitude)&appid=\(Constants.APIKEY)&units=\(units)"
        guard let wheatherUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: wheatherUrl) { data, response, error in
            guard let data = data,
                error == nil else {
                print("Error fetch request of weather")
                return
            }
            do {
                let forecast = try JSONDecoder().decode(CurrentWeather.self, from: data)
                self.loadIconFromApi(with: forecast.weather[0].icon, and: "\(Int(forecast.main.temp))\(self.unit)")
            } catch let error {
                print(error)
            }
        }.resume()
    }

    func loadIconFromApi(with iconCode: String?, and temp: String) {
        guard let iconCode = iconCode,
              let imageUrl: URL = URL(string: Constants.weatherIconUrl + iconCode + Constants.weatherIconUrlEnd) else { return }
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            if let data = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    self.weatherView.weatherViewTemperature = temp
                    self.weatherView.weatherViewImage = UIImage(data: data)
                }
            }
        }
        
    }

    func showAlert(_ message:String) {
        let alert = UIAlertController(title: "Location Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showScrollAndWeatherView() {
        UIView.animate(withDuration: 0.5) {
            self.topScrollView.alpha = 1
            self.weatherView.alpha = 1
        }
    }
}

extension FirstViewControllerController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {

        // определение текущего местоположения
        cameraLatitude = mapView.camera.target.latitude
        cameraLongitude = mapView.camera.target.longitude

    }
    
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

extension FirstViewControllerController: ScrollViewOnMapDelegate {
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
    
    func chooseParkFilter() {
        print("Park filter")
        let request = MapViewModel.FilterName.Park
        interactor?.fetchAllTestMarkers(request: request)
    }
    
    func choosePoiFilter() {
        print("Poi filter")
        let request = MapViewModel.FilterName.POI
        interactor?.fetchAllTestMarkers(request: request)
    }
    
    func chooseBeachFilter() {
        print("Beach filter")
        let request = MapViewModel.FilterName.Beach
        interactor?.fetchAllTestMarkers(request: request)
    }
    
    func showSearchView() {
        UIView.animate(withDuration: 0.25) {
            self.topScrollView.frame.origin.y = -50
            self.weatherView.alpha = 0
        } completion: { success in
            if success {
                UIView.animate(withDuration: 0.55) {
                    self.topSearchView.alpha = 1
                }
            }
        }
    }
    
    
}

extension FirstViewControllerController: TopSearchViewDelegate {
    // Скрываем поисковую строку и клавиатуру при нажатии на крестик в textField
    func clearTextField() {
        hideTopSearchView()
    }
}

extension FirstViewControllerController: ConnectivityDelegate {
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

extension FirstViewControllerController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            myCurrentLatitude = location.coordinate.latitude
            myCurrentLongitude = location.coordinate.longitude
            cameraLatitude = myCurrentLatitude
            cameraLongitude = myCurrentLongitude
            loadCurrentWeather()
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

extension FirstViewControllerController: FloatingViewDelegate {
    func floatingPanelIsHidden() {
        UIView.animate(withDuration: 0.35) {
            self.tabBarController?.tabBar.alpha = 1
        }
        self.mapView.settings.myLocationButton = true
        showScrollAndWeatherView()
    }
    
    
}
