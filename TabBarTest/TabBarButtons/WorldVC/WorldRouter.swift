//
//  WorldRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol WorldRoutingLogic {
    func routeToCountryVC()
    func routeToCityVC()
}

protocol WorldDataPassing {
    var dataStore: WorldDataStore? { get set }
}

class WorldRouter: NSObject, WorldRoutingLogic, WorldDataPassing {
    
    weak var viewController: WorldController?
    var dataStore: WorldDataStore?
    
    // MARK: - Роутинг

    // на экран выбранного города
    func routeToCountryVC() {
        let destinationVC: DescriptionCountryToBuyController = DescriptionCountryToBuyController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToLeadMore(source: dataStore!, destination: &destinationDS)
        navigateToViewContact(source: viewController!, destination: destinationVC)
    }
    
    // на экран выбранного города
    func routeToCityVC() {
        let destinationVC: CityController = CityController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToLeadMore(source: dataStore!, destination: &destinationDS)
        navigateToViewContact(source: viewController!, destination: destinationVC)
    }
    
    // MARK: - Навигация
    
    // открыть следующий город по тыку на ячееке с городами
    func navigateToViewContact(source: WorldController, destination: DescriptionCountryToBuyController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // открыть следующий город по тыку на ячееке с городами
    func navigateToViewContact(source: WorldController, destination: CityController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Передача данных
    
    func passDataToLeadMore(source: WorldDataStore, destination: inout DescriptionCountryToBuyDataStore) {
        destination.currentCountry = source.currentCity
    }
    
    func passDataToLeadMore(source: WorldDataStore, destination: inout CityDataStore) {
        destination.currentCity = source.currentCity
    }
}

