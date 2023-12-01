//
//  MapDataStore.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 04.10.2021.
//

import Foundation
import GoogleMaps

protocol MapBussinessLogic: AnyObject {
    func showCurrentMarker(request: MapViewModel.ChoosenDestinationView.Request)
    func showSelectedMarker(request: MapViewModel.ChoosenDestinationView.Request)
    func fetchAllTestMarkers(request: MapViewModel.FilterName)
    func fetchSelectedSightWithAllMarkers(withName name: String) -> GMSMarker?
    func appendAllMarkers()
    func updateFavorites(name: String)
}

protocol MapDataStore: AnyObject {
    var markers: GMSMarker? { get set }
}

class MapInteractor: MapBussinessLogic, MapDataStore {

    var presenter: MapPresentationLogic?
    var markers: GMSMarker?
    var mapMarkers = [GMSMarker]()
    
    
    func appendAllMarkers() {
        // грузим все досторпримечательности
        let worldModel = ModelForRequest(country: "Россия")
        MapWorker.downloadAllSight(worldModel: worldModel)
        fetchAllTestMarkers(request: .All)
    }
    
    func fetchAllTestMarkers(request: MapViewModel.FilterName) {
        switch request {
        case .All:
            presenter?.presentAllMarkers(response: returnAllTestMarkers())
            
        case .Museum: break
        case .Park: break
        case .POI: break
        case .Beach:
            presenter?.presentAllMarkers(response: returnAllTestFilterMarkers())
        }
    }
    
    private func returnAllTestFilterMarkers() -> [GMSMarker] {
        var mapMarkersFilters = [GMSMarker]()
        let sydneyMarker = GMSMarker(
            position: CLLocationCoordinate2D(latitude: 59.9422, longitude: 30.3945))
        sydneyMarker.title = "New Point!"
        sydneyMarker.icon = UIImage(systemName: "sunrise")!
        
        // Add a custom 'arrow' marker pointing to Melbourne.
        let melbourneMarker = GMSMarker(
            position: CLLocationCoordinate2D(latitude: 59.88422, longitude: 30.2545))
        melbourneMarker.title = "Another Point!"
        melbourneMarker.icon = UIImage(systemName: "sunrise")!
        
        mapMarkersFilters.append(sydneyMarker)
        mapMarkersFilters.append(melbourneMarker)
        
        return mapMarkersFilters
    }
    
    // Делаем выбранный маркер с градиентом
    private func returnAllTextSelectedMarkers(selectedMarkerName: String) -> [GMSMarker] {
        var mapMarkersAll = [GMSMarker]()
        let allSights = UserDefaults.standard.getSight()
        
        for (_, val) in allSights.enumerated() where val.name == selectedMarkerName {
            
            // Основная вьюха
            let australiaMarker = GMSMarker(
                position: CLLocationCoordinate2D(latitude: val.latitude,
                                                 longitude: val.longitude))
            australiaMarker.title = val.name
            australiaMarker.appearAnimation = .pop
            australiaMarker.isFlat = true
            australiaMarker.isDraggable = true
            australiaMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            australiaMarker.iconView = UIImageView(image: UIImage(named: "emptyMarkerBackground"))
            australiaMarker.iconView?.frame = CGRect(x: 0, y: 0, width: 92, height: 92)
            australiaMarker.iconView?.contentMode = .scaleAspectFill
            australiaMarker.iconView?.layer.cornerRadius = 46
            australiaMarker.iconView?.clipsToBounds = true
            
            guard let oldBounds = australiaMarker.iconView?.bounds else { return [] }
            australiaMarker.iconView?.bounds = CGRect(origin: oldBounds.origin,
                                                      size: CGSize(width: oldBounds.size.width,
                                                                   height: oldBounds.size.height))
            
            // градиент
            let radialGradient = CAGradientLayer()
            radialGradient.type = .radial
            radialGradient.colors = [ UIColor(red: 0, green: 41/256, blue: 241/256, alpha: 1).cgColor,
                                      UIColor.clear.cgColor ]
            radialGradient.startPoint = CGPoint(x: 0.5, y: 0.5)
            radialGradient.endPoint = CGPoint(x: 1, y: 1)
            radialGradient.frame = CGRect(x: 0, y: 0, width: 92, height: 92)
            
            // картинка поверх градиента
            let markImage = UIImageView()
            markImage.image = UIImage(named: val.big_image)
            markImage.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            markImage.layer.cornerRadius = 25
            markImage.center = australiaMarker.iconView!.center
            australiaMarker.iconView?.contentMode = .scaleAspectFit
            markImage.clipsToBounds = true
            
            // вьюха для градиента
            let alphaLayer = UIView()
            alphaLayer.layer.addSublayer(radialGradient)
            alphaLayer.layer.cornerRadius = 46
            alphaLayer.frame = CGRect(x: 0, y: 0, width: 92, height: 92)
            alphaLayer.center = australiaMarker.iconView!.center
            
            alphaLayer.addSubview(markImage)
            australiaMarker.iconView?.addSubview(alphaLayer)
            mapMarkersAll.append(australiaMarker)
        }
        return mapMarkersAll
    }
    
    // отдаем все маркеры в начальном виде
    private func returnAllTestMarkers() -> [GMSMarker] {
        var mapMarkersAll = [GMSMarker]()
        let allSights = UserDefaults.standard.getSight()
        for (_, val) in allSights.enumerated() {
            let australiaMarker = GMSMarker(
                position: CLLocationCoordinate2D(latitude: val.latitude,
                                                 longitude: val.longitude))
            australiaMarker.title = val.name
            australiaMarker.appearAnimation = .pop
            australiaMarker.isFlat = true
            australiaMarker.isDraggable = true
            australiaMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            australiaMarker.iconView = UIImageView(image: UIImage(named: val.big_image))
            australiaMarker.iconView?.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            australiaMarker.iconView?.contentMode = .scaleAspectFill
            australiaMarker.iconView?.layer.cornerRadius = 25
            australiaMarker.iconView?.clipsToBounds = true
            
            let border = UIView()
            border.backgroundColor = .clear
            border.layer.borderColor = UIColor.white.cgColor
            border.layer.borderWidth = 2
            border.layer.cornerRadius = (australiaMarker.iconView?.frame.width)! / 2
            border.frame = australiaMarker.iconView!.frame
            border.center = australiaMarker.iconView!.center
            australiaMarker.iconView?.addSubview(border)
            
            mapMarkersAll.append(australiaMarker)
        }
        print("mapMarkersAll:\(mapMarkersAll)")
        mapMarkers = mapMarkersAll
        return mapMarkersAll
    }
    
    // Выбираем конкретную достопримечательность из коллекциии сниу экрана
    func fetchSelectedSightWithAllMarkers(withName name: String) -> GMSMarker? {
        var marker: GMSMarker? = nil
        for (_, value) in mapMarkers.enumerated() where value.title == name {
                marker = value
        }
        return marker
    }
    
    func showCurrentMarker(request: MapViewModel.ChoosenDestinationView.Request) {
        //        здесь берем данные из базы по конкретному названию маркера из данной страны и текущего города
        let allSights = UserDefaults.standard.getSight()
        for (_, val) in allSights.enumerated() where request.marker == val.name {
            //            когда нашли нужное место с его данными - передаем в перентер
            //            изменить модель response для дальнейшего отображения
            //            для теста пока нету кор даты пока что только название
            print("request.marker:\(request.marker) == val.name:\(val.name)")
            
            presenter?.presentChoosenDestinationView(response: returnAllTextSelectedMarkers(selectedMarkerName: val.name))
        }
    }
    
    func showSelectedMarker(request: MapViewModel.ChoosenDestinationView.Request) {
        //        здесь берем данные из базы по конкретному названию маркера из данной страны и текущего города
        let allSights = UserDefaults.standard.getSight()
        for (_, val) in allSights.enumerated() where request.marker == val.name {
            //            когда нашли нужное место с его данными - передаем в перентер
            //            изменить модель response для дальнейшего отображения
            //            для теста пока нету кор даты пока что только название
            
            print("request.marker:\(request.marker) == val.name:\(val.name)")
            presenter?.presentSelectedDestinationView(response: mapMarkers)
        }
    }
    
    func updateFavorites(name: String) {
        ManagesFavorites.updateFavorite(withName: name)
    }
}
