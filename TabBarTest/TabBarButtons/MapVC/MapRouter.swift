//
//  MapRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol MapRoutingLogic: AnyObject {
    func routeToCityVC()
    func routeToUnboardingVC()
}

protocol MapDataPassing: AnyObject {
    var dataStore: MapDataStore? { get set }
}

class MapRouter: NSObject, MapRoutingLogic {
    
    weak var viewController: MapController?
    
    // MARK: - Routing
    
    func routeToCityVC() {
        let destinationVC: CityController = CityController.loadFromStoryboard()
        navigateToViewContact(source: viewController!, destination: destinationVC)
    }
    
    // На экран онбординга
    func routeToUnboardingVC() {
        let destinationVC: UnboardingController = UnboardingController.loadFromStoryboard()
        navigateToUnboarding(source: viewController!, destination: destinationVC)
    }

    // MARK: - Navigation
    
    func navigateToViewContact(source: MapController, destination: CityController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // Открыть онбординг
    func navigateToUnboarding(source: MapController!, destination: UnboardingController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
}
