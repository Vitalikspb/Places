//
//  MapDataStore.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 04.10.2021.
//

import Foundation
import GoogleMaps
import SnapKit

protocol MapBussinessLogic: AnyObject {
    func showMarkersOnCity(name: String)
    func showCurrentMarker(request: MapViewModel.ChoosenDestinationView.Request)
    func showSelectedMarker(request: MapViewModel.ChoosenDestinationView.Request)
    func fetchAllTestMarkers(request: TypeSight)
    func fetchSelectedSightWithAllMarkers(withName name: String) -> GMSMarker?
    func fetchAllFavorites(selected: Bool)
    func appendAllMarkers()
    func updateFavorites(name: String)
    func searchWithCaracter(character: String)
    func markerWithCountOfCityMarkers()
}

protocol MapDataStore: AnyObject {
    var markers: GMSMarker? { get set }
}

class MapInteractor: MapBussinessLogic, MapDataStore {

    var presenter: MapPresentationLogic?
    var markers: GMSMarker?
    var mapMarkers = [GMSMarker]()
    
    
    // Показать все начальные маркеры
    func appendAllMarkers() {
        presenter?.presentAllMarkers(response: returnAllTestMarkers())
    }
    
    // Установка всем городам маркеров с количеством маркеров по городам
    func markerWithCountOfCityMarkers() {
        var resultMarkers = [GMSMarker]()
        
        // Все города для определения локации
        let tempWorldCountry = UserDefaults.standard.getSightDescription()
        for (_,val) in tempWorldCountry.enumerated() {
            let marker = setEmptyMarker(cityName: val.name,
                                        location: CLLocation(latitude: val.latitude,
                                                             longitude: val.longitude),
                                        countSights: val.sight_count)
            resultMarkers.append(marker)
        }
        presenter?.presentEmptyCityMarkers(response: resultMarkers)
    }
    
    // Фильтрация по избранным достопримечательностям
    func fetchAllFavorites(selected: Bool) {
        let favorites = UserDefaults.standard.getFavorites()
        if selected || favorites.isEmpty {
            appendAllMarkers()
        } else {
            var filteredMarkers: [GMSMarker] = []
            for (_,val) in favorites.enumerated() {
                let marker = setMarker(name: val.name,
                                       location: CLLocation(latitude: val.latitude,
                                                            longitude: val.longitude),
                                       imageName: val.big_image)
                filteredMarkers.append(marker)
            }
            presenter?.presentAllMarkers(response: filteredMarkers)
        }
    }
    
    // Фильтрация по нажатию кнопок из верхних фильтров
    func fetchAllTestMarkers(request: TypeSight) {
        let model = returnAllTestFilterMarkers(request: request)
        presenter?.presentAllMarkers(response: model)
    }
    
    // Фильтрация по текущему города
    func showMarkersOnCity(name: String) {
        let allSight = UserDefaults.standard.getSight()

        var resultSight = [Sight]()
        
        if name == "Город" && name == "посёлок" && name == "деревня" && name == "район" {
            resultSight = allSight
        } else {
            resultSight = allSight.filter( { $0.city == name} )
        }
        var mapMarkersAll = [GMSMarker]()
        
        for (_, val) in resultSight.enumerated() {
            let marker = setMarker(name: val.name,
                                   location: CLLocation(latitude: val.latitude, 
                                                        longitude: val.longitude),
                                   imageName: val.big_image)
            mapMarkersAll.append(marker)
        }
        presenter?.presentAllMarkers(response: mapMarkersAll)
    }
    
    // Инициализация стандартного маркера
    func setMarker(name: String, location: CLLocation, imageName: String) -> GMSMarker {
        let australiaMarker = GMSMarker(
            position: CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                             longitude: location.coordinate.longitude))
        australiaMarker.title = name
        australiaMarker.appearAnimation = .pop
        australiaMarker.isFlat = true
        australiaMarker.isDraggable = true
        australiaMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        australiaMarker.iconView = UIImageView(image: UIImage(named: imageName))
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
        
        return australiaMarker
    }
    
    // Инициализация стандартного маркера
    func setEmptyMarker(cityName: String, location: CLLocation, countSights: Int) -> GMSMarker {
        let australiaMarker = GMSMarker(
            position: CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                             longitude: location.coordinate.longitude))
        australiaMarker.title = cityName
        australiaMarker.appearAnimation = .pop
        australiaMarker.isFlat = true
        australiaMarker.isDraggable = true
        australiaMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        australiaMarker.iconView =  UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        australiaMarker.iconView?.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
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
        
        let countLabel = UILabel()
        countLabel.text = "\(countSights)"
        countLabel.textColor = .setCustomColor(color: .titleText)
        countLabel.font = .setCustomFont(name: .regular, andSize: 16)
        countLabel.backgroundColor = .clear
        countLabel.contentMode = .center
        
        border.addSubview(countLabel)
        countLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        australiaMarker.iconView?.addSubview(border)
        return australiaMarker
    }
    
    // Фильтрация по тексту из поиска
    func searchWithCaracter(character: String) {
        if character == "" {
            appendAllMarkers()
        } else {
            var filteredMarkers: [GMSMarker] = []
            let allSight = UserDefaults.standard.getSight()
            for (_,val) in allSight.enumerated() where val.name.contains(character) {
                let marker = setMarker(name: val.name,
                                       location: CLLocation(latitude: val.latitude,
                                                            longitude: val.longitude),
                                       imageName: val.big_image)
                filteredMarkers.append(marker)
            }
            presenter?.presentAllMarkers(response: filteredMarkers)
        }
    }
    
    // Фильтрация по нажатию кнопок из верхних фильтров
    private func returnAllTestFilterMarkers(request: TypeSight) -> [GMSMarker] {
        let allSight = UserDefaults.standard.getSight()
        let resultSight = allSight.filter( { $0.type.rawValue ==  request.rawValue} )
        var mapMarkersAll = [GMSMarker]()
        
        for (_, val) in resultSight.enumerated() {
            let marker = setMarker(name: val.name,
                      location: CLLocation(latitude: val.latitude,
                                           longitude: val.longitude),
                      imageName: val.big_image)
            mapMarkersAll.append(marker)
        }
        
        return mapMarkersAll
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
            let marker = setMarker(name: val.name,
                      location: CLLocation(latitude: val.latitude,
                                           longitude: val.longitude),
                      imageName: val.big_image)
            
            mapMarkersAll.append(marker)
        }
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
            presenter?.presentChoosenDestinationView(
                response: returnAllTextSelectedMarkers(selectedMarkerName: val.name),
                selectedSight: val)
        }
    }
    
    func showSelectedMarker(request: MapViewModel.ChoosenDestinationView.Request) {
        //        здесь берем данные из базы по конкретному названию маркера из данной страны и текущего города
        let allSights = UserDefaults.standard.getSight()
        for (_, val) in allSights.enumerated() where request.marker == val.name {
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
