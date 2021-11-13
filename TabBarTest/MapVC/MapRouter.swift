//
//  MapRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol MapRoutingLogic {
    func routeToCityVC()
}

protocol MapDataPassing {
    var dataStore: MapDataStore? { get set }
}

class MapRouter: NSObject, MapRoutingLogic {
    
    weak var viewController: MapController?
    
    // MARK: - Routing
    
    func routeToCityVC() {
        let destinationVC: CityController = CityController.loadFromStoryboard()
        navigateToViewContact(source: viewController!, destination: destinationVC)
    }

    // MARK: - Navigation
    
    func navigateToViewContact(source: MapController, destination: CityController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
}
