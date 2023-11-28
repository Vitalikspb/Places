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
        MapWorker.downloadAllSight(worldModel: worldModel) {
            print("Загружены и сохранены все достопримечательности")
            self.createSightMarkerArray()
        }
    }
    
    private func createSightMarkerArray() {
        let allSights = UserDefaults.standard.getSight()
        
        // Делаем из них маркеры
        for (ind,val) in allSights.enumerated() {
            let iconWidthHeight: CGFloat = 92.0
            let tempMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: val.latitude,
                                                                        longitude: val.longitude))
            tempMarker.title = val.name
            tempMarker.appearAnimation = .pop
            tempMarker.isFlat = true
            tempMarker.isDraggable = true
            tempMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            tempMarker.iconView = UIView()// UIImageView(image: UIImage(named: val.big_image))
            tempMarker.iconView?.frame = CGRect(x: 0, y: 0, width: iconWidthHeight, height: iconWidthHeight)
            tempMarker.iconView?.contentMode = .scaleToFill
            tempMarker.iconView?.clipsToBounds = true
            tempMarker.iconView?.layer.cornerRadius = iconWidthHeight / 2
            
            guard let oldBounds = tempMarker.iconView?.bounds else { return }
            tempMarker.iconView?.bounds = CGRect(origin: oldBounds.origin,
                                                 size: CGSize(width: oldBounds.size.width,
                                                              height: oldBounds.size.height))
            
            
            // gradient
//            let radialGradient = CAGradientLayer()
//            radialGradient.type = .radial
//            radialGradient.colors = [UIColor(red: 0, green: 41/256, blue: 241/256, alpha: 1).cgColor,
//                                     UIColor.clear.cgColor ]
//            radialGradient.startPoint = CGPoint(x: 0.5, y: 0.5)
//            radialGradient.endPoint = CGPoint(x: 1, y: 1)
//            radialGradient.frame = CGRect(x: 0, y: 0, width: iconWidthHeight, height: iconWidthHeight)
            
            let alphaLayer = UIView()
//            alphaLayer.layer.addSublayer(radialGradient)
            alphaLayer.layer.cornerRadius = iconWidthHeight / 2
            alphaLayer.frame = CGRect(x: 0, y: 0, width: iconWidthHeight, height: iconWidthHeight)
            alphaLayer.center = tempMarker.iconView!.center
            alphaLayer.clipsToBounds = true
            
            let border = UIView()
            border.backgroundColor = .white
            border.layer.cornerRadius = 26
            border.frame = CGRect(x: 0, y: 0, width: 52, height: 52)
            border.center = tempMarker.iconView!.center
            
            
            let markImage = UIImageView()
            markImage.image = UIImage(named: val.big_image)
            markImage.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            markImage.layer.cornerRadius = 25
            markImage.center = tempMarker.iconView!.center
            tempMarker.iconView?.contentMode = .scaleAspectFit
            markImage.clipsToBounds = true
            
            alphaLayer.addSubview(border)
            alphaLayer.addSubview(markImage)
            tempMarker.iconView?.addSubview(alphaLayer)
            
            mapMarkers.append(tempMarker)
        }
        presenter?.presentAllMarkers(response: mapMarkers)
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
    
    func updateFavorites(name: String) {
        ManagesFavorites.updateFavorite(withName: name)
    }
}
