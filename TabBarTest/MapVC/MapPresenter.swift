//
//  MapPresenter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 04.10.2021.
//

import Foundation
import GoogleMaps

protocol MapPresentationLogic {
    func presentChoosenDestinationView(response: MapViewModel.ChoosenDestinationView.Response)
    func presentAllMarkers(response: [GMSMarker])
}

final class MapPresenter: MapPresentationLogic {
    weak var mapController: MapController?
    
    func presentChoosenDestinationView(response: MapViewModel.ChoosenDestinationView.Response) {
        
        let viewModel = MapViewModel.ChoosenDestinationView.ViewModel(destinationName: response.destinationName.name)
        mapController?.displayChoosenDestination(viewModel: viewModel)
    }
    
    func presentAllMarkers(response: [GMSMarker]) {
        mapController?.displayMarkers(filter: response)
    }
    
}
