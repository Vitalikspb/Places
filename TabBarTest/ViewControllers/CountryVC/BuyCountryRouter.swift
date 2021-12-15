//
//  BuyCountryRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol BuyCountryRoutingLogic {
    func routeToBuyVC()
}

protocol BuyCountryDataPassing {
    var dataStore: BuyCountryDataStore? { get set }
}

class BuyCountryRouter: NSObject, BuyCountryRoutingLogic, BuyCountryDataPassing {
    
    weak var viewController: BuyCountryController?
    var dataStore: BuyCountryDataStore?
    
    // MARK: - Роутинг
    
    // на экран покупки страны
    func routeToBuyVC() {
        let destinationVC: CityController = CityController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToLeadMore(source: dataStore!, destination: &destinationDS)
        navigateToViewContact(source: viewController!, destination: destinationVC)
    }

    // MARK: - Навигация
    
    // открыть следующий город по тыку на ячееке с городами
    func navigateToViewContact(source: BuyCountryController, destination: CityController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Передача данных
    
    func passDataToLeadMore(source: BuyCountryDataStore, destination: inout CityDataStore) {
        destination.currentCity = source.currentCity
    }
}

