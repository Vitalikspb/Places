//
//  MapDataStore.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 04.10.2021.
//

import Foundation
import GoogleMaps

protocol MapBussinessLogic {
    func showCurrentMarker(request: MapViewModel.ChoosenDestinationView.Request)
    func fetchAllTestMarkers(request: MapViewModel.FilterName)
}

protocol MapDataStore {
    var markers: GMSMarker? { get set }
}

class MapInteractor: MapBussinessLogic {
    
    func fetchAllTestMarkers(request: MapViewModel.FilterName) {
        switch request {
        case .Alltest, .AllRelease:
            presenter?.presentAllMarkers(response: returnAllTestMarkers())
        case .Museum, .Park, .POI, .Beach:
            presenter?.presentAllMarkers(response: returnAllTestFilterMarkers())
        }
    }
    
    private func returnAllTestFilterMarkers() -> [GMSMarker] {
        var mapMarkers = [GMSMarker]()
        let sydneyMarker = GMSMarker(
            position: CLLocationCoordinate2D(latitude: 59.9422, longitude: 30.3945))
        sydneyMarker.title = "New Point!"
        sydneyMarker.icon = UIImage(systemName: "terminal")!
        
        // Add a custom 'arrow' marker pointing to Melbourne.
        let melbourneMarker = GMSMarker(
            position: CLLocationCoordinate2D(latitude: 59.88422, longitude: 30.2545))
        melbourneMarker.title = "Another Point!"
        melbourneMarker.icon = UIImage(systemName: "sunrise")!
        
        mapMarkers.append(sydneyMarker)
        mapMarkers.append(melbourneMarker)
        return mapMarkers
    }
    
    private func returnAllTestMarkers() -> [GMSMarker] {
        var mapMarkers = [GMSMarker]()

        let australiaMarker = GMSMarker(
          position: CLLocationCoordinate2D(latitude: 59.9422, longitude: 30.3945))
        australiaMarker.title = "Australia"
        australiaMarker.appearAnimation = .pop
        australiaMarker.isFlat = true
        australiaMarker.isDraggable = true
        australiaMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        australiaMarker.iconView = UIImageView(image: UIImage(named: "NY50"))
        australiaMarker.iconView?.contentMode = .center
        
        let sydneyMarker1 = GMSMarker(
            position: CLLocationCoordinate2D(latitude: 59.9122, longitude: 30.3445))
        sydneyMarker1.title = "New Point!"
        sydneyMarker1.icon = UIImage(systemName: "terminal")!
        
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
        return mapMarkers
    }
    
    var presenter: MapPresentationLogic?
    var worker = MapWorker()
    var markers: GMSMarker?
    
    func showCurrentMarker(request: MapViewModel.ChoosenDestinationView.Request) {
        
        //        здесь берем данные из базы по конкретному названию маркера из данной страны и текущего города
        if request.marker == "Australia" {
//            когда нашли нужное место с его данными - передаем в перентер
//            изменить модель response для дальнейшего отображения
//            для теста пока нету кор даты пока что только название
            var mapMarkers = [GMSMarker]()

            let australiaMarker = GMSMarker(
              position: CLLocationCoordinate2D(latitude: 59.9422, longitude: 30.3945))
            australiaMarker.title = "Australia"
            australiaMarker.appearAnimation = .pop
            australiaMarker.isFlat = true
            australiaMarker.isDraggable = true
            australiaMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            australiaMarker.iconView = UIImageView(image: UIImage(named: "NY50"))
            australiaMarker.iconView?.contentMode = .center
            
            
            
            
            guard let oldBounds = australiaMarker.iconView?.bounds else { return }
            australiaMarker.iconView?.bounds = CGRect(
              origin: oldBounds.origin,
                size: CGSize(width: oldBounds.size.width, height: oldBounds.size.height))
            
            let sydneyGlow = UIView()
            sydneyGlow.backgroundColor = .clear
            sydneyGlow.layer.borderColor = UIColor.red.cgColor
            sydneyGlow.layer.borderWidth = 2
            sydneyGlow.layer.cornerRadius = (australiaMarker.iconView?.frame.width)! / 2
            sydneyGlow.frame = australiaMarker.iconView!.frame
            sydneyGlow.center = australiaMarker.iconView!.center
            
            australiaMarker.iconView?.addSubview(sydneyGlow)
//            sydneyGlow.center = CGPoint(x: oldBounds.size.width, y: oldBounds.size.height)
            
            
            
            
            
            
            
            
            
            
            
            
     
            
            let sydneyMarker1 = GMSMarker(
                position: CLLocationCoordinate2D(latitude: 59.9122, longitude: 30.3445))
            sydneyMarker1.title = "New Point!"
            sydneyMarker1.icon = UIImage(systemName: "terminal")!
            
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
            
            
            
            
            
            presenter?.presentChoosenDestinationView(response: mapMarkers)
        }
    }
}
