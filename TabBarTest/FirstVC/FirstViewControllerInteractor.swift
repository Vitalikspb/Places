//
//  FirstViewControllerInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 04.10.2021.
//

import Foundation
import GoogleMaps

protocol FirstViewBussinessLogic {
    func showCurrentMarker(request: MapViewModel.ChoosenDestinationView.Request)
    func fetchAllTestMarkers(request: MapViewModel.FilterName)
}

protocol FirstViewDataStore {
    var markers: GMSMarker? { get set }
}


class FirstViewControllerInteractor: FirstViewBussinessLogic {
    
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
        let sydneyMarker = GMSMarker(
            position: CLLocationCoordinate2D(latitude: 59.9422, longitude: 30.3945))
        sydneyMarker.title = "New Point!"
        sydneyMarker.icon = UIImage(systemName: "terminal")!
        
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
        
        mapMarkers.append(sydneyMarker)
        mapMarkers.append(sydneyMarker1)
        mapMarkers.append(melbourneMarker)
        mapMarkers.append(melbourneMarker1)
        return mapMarkers
    }
    
    var presenter: FirstViewPresentationLogic?
    var worker = FirstViewControllerWorker()
    var markers: GMSMarker?
    
    func showCurrentMarker(request: MapViewModel.ChoosenDestinationView.Request) {
        print("interator is workind and fetching data ")
        // тут логика показа выбранного маркера выбор данных по конкретному маркеру из всех маркеров на карте
    }
}
