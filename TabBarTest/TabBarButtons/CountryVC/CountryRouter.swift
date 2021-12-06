//
//  CountryRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol CountryRoutingLogic {
    func routeToCityVC()
    func routeToFavouritesVC()
}

protocol CountryDataPassing {
    var dataStore: CountryDataStore? { get set }
}

class CountryRouter: NSObject, CountryRoutingLogic {
    
    weak var viewController: CountryController?
    
    // MARK: - Routing
    func routeToFavouritesVC() {
        let destinationVC: FavouritesController = FavouritesController.loadFromStoryboard()
        navigateToFavourites(source: viewController!, destination: destinationVC)
        
    }
    
    func routeToCityVC() {
        let destinationVC: CityController = CityController.loadFromStoryboard()
        navigateToViewContact(source: viewController!, destination: destinationVC)
    }

    // MARK: - Navigation
    // открыть избранное
    func navigateToFavourites(source: CountryController, destination: FavouritesController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    // открыть следующий город по тыку на ячееке с городами
    func navigateToViewContact(source: CountryController, destination: CityController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
}

