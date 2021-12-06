//
//  MapPresenter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 04.10.2021.
//

import Foundation
import GoogleMaps

protocol MapPresentationLogic {
    func presentChoosenDestinationView(response: [GMSMarker])
    func presentAllMarkers(response: [GMSMarker])
}

final class MapPresenter: MapPresentationLogic {
    weak var mapController: MapController?
    
    func presentChoosenDestinationView(response: [GMSMarker]) {
        mapController?.displayChoosenDestination(viewModel: MapViewModel.ChoosenDestinationView.ViewModel(markers: response))
    }
    
    func presentAllMarkers(response: [GMSMarker]) {
        mapController?.displayMarkers(filter: response)
    }
    
}
