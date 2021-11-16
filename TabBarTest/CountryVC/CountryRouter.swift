//
//  CountryRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit






protocol CountryRoutingLogic {
    func routeToCityVC()
}

protocol CountryDataPassing {
    var dataStore: CountryDataStore? { get set }
}

class CountryRouter: NSObject, CountryRoutingLogic {
    
    weak var viewController: CountryController?
    
    // MARK: - Routing
    
    func routeToCityVC() {
        let destinationVC: CityController = CityController.loadFromStoryboard()
        navigateToViewContact(source: viewController!, destination: destinationVC)
    }

    // MARK: - Navigation
    
    func navigateToViewContact(source: CountryController, destination: CityController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
}

