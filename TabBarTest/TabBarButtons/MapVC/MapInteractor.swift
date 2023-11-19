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
}

protocol MapDataStore: AnyObject {
    var markers: GMSMarker? { get set }
}

class MapInteractor: MapBussinessLogic, MapDataStore {
    
    var presenter: MapPresentationLogic?
    var worker = MapWorker()
    var markers: GMSMarker?
    var mapMarkers = [GMSMarker]()
    
    func appendAllMarkers() {
        
        let australiaMarker = GMSMarker(
          position: CLLocationCoordinate2D(latitude: 59.9422, longitude: 30.3945))
        australiaMarker.title = "Эрмитаж"
        australiaMarker.appearAnimation = .pop
        australiaMarker.isFlat = true
        australiaMarker.isDraggable = true
        australiaMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        australiaMarker.iconView = UIImageView(image: UIImage(named: "NY50"))
        australiaMarker.iconView?.frame = CGRect(x: 0, y: 0, width: 92, height: 92)
        australiaMarker.iconView?.contentMode = .center
        
        
        
        
        
        
        guard let oldBounds = australiaMarker.iconView?.bounds else { return }
        australiaMarker.iconView?.bounds = CGRect(
          origin: oldBounds.origin,
            size: CGSize(width: oldBounds.size.width, height: oldBounds.size.height))

        

        let alphaLayer = UIView()
        // gradient
        let radialGradient = CAGradientLayer()
        radialGradient.type = .radial
        radialGradient.colors = [ UIColor(red: 0, green: 41/256, blue: 241/256, alpha: 1).cgColor,
                                  UIColor.clear.cgColor ]
        radialGradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        radialGradient.endPoint = CGPoint(x: 1, y: 1)

        radialGradient.frame = CGRect(x: 0, y: 0, width: 92, height: 92)
        alphaLayer.layer.addSublayer(radialGradient)
        // gradient
        
        // only alpha
        //alphaLayer.backgroundColor = UIColor(red: 0, green: 90/256, blue: 241/256, alpha: 0.45)
        // only alpha
        
        alphaLayer.layer.cornerRadius = 46
        alphaLayer.frame = CGRect(x: 0, y: 0, width: 92, height: 92)
        alphaLayer.center = australiaMarker.iconView!.center

        
        let border = UIView()
        border.backgroundColor = .white
        border.layer.cornerRadius = 26
        border.frame = CGRect(x: 0, y: 0, width: 52, height: 52)
        border.center = australiaMarker.iconView!.center

        
        let markImage = UIImageView()
        markImage.image = UIImage(named: "NY50")
        markImage.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        markImage.layer.cornerRadius = 25
        markImage.center = australiaMarker.iconView!.center
        
        alphaLayer.addSubview(border)
        alphaLayer.addSubview(markImage)
        australiaMarker.iconView?.addSubview(alphaLayer)

        
        
        
        
        
        
        
        
        
 
        
        let sydneyMarker1 = GMSMarker(
            position: CLLocationCoordinate2D(latitude: 59.9122, longitude: 30.3445))
        sydneyMarker1.title = "Русский музей"
        sydneyMarker1.icon = UIImage(systemName: "sunrise")!
        
        // Add a custom 'arrow' marker pointing to Melbourne.
        let melbourneMarker = GMSMarker(
            position: CLLocationCoordinate2D(latitude: 59.88422, longitude: 30.2545))
        melbourneMarker.title = "Another Point!"
        melbourneMarker.icon = UIImage(systemName: "sunrise")!
        
        // Add a custom 'arrow' marker pointing to Melbourne.
        let melbourneMarker1 = GMSMarker(
            position: CLLocationCoordinate2D(latitude: 59.89422, longitude: 30.2245))
        melbourneMarker1.title = "Another Point!"
        melbourneMarker1.icon = UIImage(systemName: "sunrise")!
        
        mapMarkers.append(australiaMarker)
        mapMarkers.append(sydneyMarker1)
        mapMarkers.append(melbourneMarker)
        mapMarkers.append(melbourneMarker1)
    }
    
    func fetchAllTestMarkers(request: MapViewModel.FilterName) {
        switch request {
        case .Alltest, .AllRelease:
            presenter?.presentAllMarkers(response: returnAllTestMarkers())
            
        case .Museum, .Park, .POI, .Beach:
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
    
    private func returnAllTestMarkers() -> [GMSMarker] {
        var mapMarkersAll = [GMSMarker]()

        let australiaMarker = GMSMarker(
          position: CLLocationCoordinate2D(latitude: 59.9422, longitude: 30.3945))
        australiaMarker.title = "Эрмитаж"
        australiaMarker.appearAnimation = .pop
        australiaMarker.isFlat = true
        australiaMarker.isDraggable = true
        australiaMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        australiaMarker.iconView = UIImageView(image: UIImage(named: "NY50"))
        australiaMarker.iconView?.contentMode = .center

        let border = UIView()
        border.backgroundColor = .clear
        border.layer.borderColor = UIColor.white.cgColor
        border.layer.borderWidth = 2
        border.layer.cornerRadius = (australiaMarker.iconView?.frame.width)! / 2
        border.frame = australiaMarker.iconView!.frame
        border.center = australiaMarker.iconView!.center
        australiaMarker.iconView?.addSubview(border)

        let sydneyMarker1 = GMSMarker(
            position: CLLocationCoordinate2D(latitude: 59.9122, longitude: 30.3445))
        sydneyMarker1.title = "Русский музей"
        sydneyMarker1.icon = UIImage(systemName: "sunrise")!

        // Add a custom 'arrow' marker pointing to Melbourne.
        let melbourneMarker = GMSMarker(
            position: CLLocationCoordinate2D(latitude: 59.88422, longitude: 30.2545))
        melbourneMarker.title = "Another Point!"
        melbourneMarker.icon = UIImage(systemName: "sunrise")!

        // Add a custom 'arrow' marker pointing to Melbourne.
        let melbourneMarker1 = GMSMarker(
            position: CLLocationCoordinate2D(latitude: 59.89422, longitude: 30.2245))
        melbourneMarker1.title = "Another Point!"
        melbourneMarker1.icon = UIImage(systemName: "sunrise")!

        mapMarkersAll.append(australiaMarker)
        mapMarkersAll.append(sydneyMarker1)
        mapMarkersAll.append(melbourneMarker)
        mapMarkersAll.append(melbourneMarker1)
        
        return mapMarkersAll
    }
    
    func fetchSelectedSightWithAllMarkers(withName name: String) -> GMSMarker? {
        var marker: GMSMarker? = nil
        for (_, value) in mapMarkers.enumerated() {
            if value.title == name {
                marker = value
            }
        }
        return marker
    }
    
    func showCurrentMarker(request: MapViewModel.ChoosenDestinationView.Request) {
        
//        здесь берем данные из базы по конкретному названию маркера из данной страны и текущего города
        if request.marker == "Эрмитаж" {
//            когда нашли нужное место с его данными - передаем в перентер
//            изменить модель response для дальнейшего отображения
//            для теста пока нету кор даты пока что только название
            presenter?.presentChoosenDestinationView(response: mapMarkers)
        }
    }
    
    func showSelectedMarker(request: MapViewModel.ChoosenDestinationView.Request) {
        //        здесь берем данные из базы по конкретному названию маркера из данной страны и текущего города
                if request.marker == "Эрмитаж" {
        //            когда нашли нужное место с его данными - передаем в перентер
        //            изменить модель response для дальнейшего отображения
        //            для теста пока нету кор даты пока что только название
                    presenter?.presentSelectedDestinationView(response: mapMarkers)
                }
    }
}
