//
//  FirstViewControllerPresenter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 04.10.2021.
//

import Foundation
import GoogleMaps

protocol FirstViewPresentationLogic {
    func presentChoosenDestinationView(response: MapViewModel.ChoosenDestinationView.Response)
    func presentAllMarkers(response: [GMSMarker])
}

final class FirstViewControllerPresenter: FirstViewPresentationLogic {
    
    
    
    weak var firstViewController: FirstViewControllerController?
    
    func presentChoosenDestinationView(response: MapViewModel.ChoosenDestinationView.Response) {
        
        let viewModel = MapViewModel.ChoosenDestinationView.ViewModel(destinationName: response.destinationName.name)
        firstViewController?.displayChoosenDestination(viewModel: viewModel)
    }
    
    func presentAllMarkers(response: [GMSMarker]) {
        firstViewController?.displayMarkers(filter: response)
    }
    
}
