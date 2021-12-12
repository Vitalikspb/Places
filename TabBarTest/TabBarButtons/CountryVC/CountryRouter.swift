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

class CountryRouter: NSObject, CountryRoutingLogic, CountryDataPassing {
    
    weak var viewController: CountryController?
    var dataStore: CountryDataStore?
    
    // MARK: - Роутинг
    // на экран сохраненных достопримечательностей
    func routeToFavouritesVC() {
        let destinationVC: FavouritesController = FavouritesController.loadFromStoryboard()
        navigateToFavourites(source: viewController!, destination: destinationVC)
    }
    // на экран выбранного города
    func routeToCityVC() {
        let destinationVC: CityController = CityController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToLeadMore(source: dataStore!, destination: &destinationDS)
        navigateToViewContact(source: viewController!, destination: destinationVC)
    }

    // MARK: - Навигация
    // открыть избранное
    func navigateToFavourites(source: CountryController, destination: FavouritesController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // открыть следующий город по тыку на ячееке с городами
    func navigateToViewContact(source: CountryController, destination: CityController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Передача данных
    func passDataToLeadMore(source: CountryDataStore, destination: inout CityDataStore) {
        destination.currentCity = source.currentCity
    }
}

