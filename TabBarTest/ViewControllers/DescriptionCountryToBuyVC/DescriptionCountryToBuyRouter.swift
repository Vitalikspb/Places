//
//  DescriptionCountryToBuyRouter.swift
//  TabBarTest
//
//  Created by ViceCode on 16.12.2021.
//

import Foundation

protocol DescriptionCountryToBuyRoutingLogic {
    func routeToFavouritesVC()
    func routeToInterestingEventsVC()
    func routeToExibitionVC()
}

protocol DescriptionCountryToBuyDataPassing {
    var dataStore: DescriptionCountryToBuyDataStore? { get }
}

class DescriptionCountryToBuyRouter: NSObject, DescriptionCountryToBuyRoutingLogic, DescriptionCountryToBuyDataPassing {
    
    var dataStore: DescriptionCountryToBuyDataStore?
    weak var viewController: DescriptionCountryToBuyController?
    
    // MARK: - Роутинг
    // на экран сохраненных достопримечательностей
    func routeToFavouritesVC() {
        let destinationVC: FavouritesController = FavouritesController.loadFromStoryboard()
        navigateToFavourites(source: viewController!, destination: destinationVC)
    }
    // На экран интересные события
    func routeToInterestingEventsVC() {
        let destinationVC: IntrestingEventsController = IntrestingEventsController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToIntrestingEvents(source: dataStore!, destination: &destinationDS)
        navigateToIntrestingEvents(source: viewController!, destination: destinationVC)
    }
    // на экран билеты на экскурсию
    func routeToExibitionVC() {
        let destinationVC: ExibitionsController = ExibitionsController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToExibitions(source: dataStore!, destination: &destinationDS)
        navigateToExibitions(source: viewController!, destination: destinationVC)
    }

    // MARK: - Навигация
    // открыть избранное
    func navigateToFavourites(source: DescriptionCountryToBuyController, destination: FavouritesController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    // Открыть интересные события
    func navigateToIntrestingEvents(source: DescriptionCountryToBuyController, destination: IntrestingEventsController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    func navigateToExibitions(source: DescriptionCountryToBuyController!, destination: ExibitionsController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Передача данных
    func passDataToIntrestingEvents(source: DescriptionCountryToBuyDataStore, destination: inout IntrestingEventsDataStore) {
        destination.currentCity = source.currentCountry
    }
    
    func passDataToExibitions(source: DescriptionCountryToBuyDataStore, destination: inout ExibitionsDataStore) {
        destination.currentCity = source.currentCountry
    }
}
