//
//  CountryRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol CurrentCityRoutingLogic {
    func routeToCityVC()
    func routeToFavouritesVC()
    func routeToInterestingEventsVC()
    func routeToExibitionVC()
    func routeToRentAutoVC()
}

protocol CurrentCityDataPassing {
    var dataStore: CurrentCityDataStore? { get set }
}

class CurrentCityRouter: NSObject, CurrentCityRoutingLogic, CurrentCityDataPassing {
    
    weak var viewController: CurrentCityController?
    var dataStore: CurrentCityDataStore?
    
    // MARK: - Роутинг
    // показать модальный экран со списком компаний аренды автомобилей
    func routeToRentAutoVC() {
        let destination: RentAutoController = RentAutoController.loadFromStoryboard()
        presentModalRentAuto(source: viewController!, destination: destination)
    }
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
    // на экран выбранного города
    func routeToCityVC() {
        let destinationVC: CityController = CityController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToLeadMore(source: dataStore!, destination: &destinationDS)
        navigateToViewContact(source: viewController!, destination: destinationVC)
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
    func navigateToFavourites(source: CurrentCityController, destination: FavouritesController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    // Открыть интересные события
    func navigateToIntrestingEvents(source: CurrentCityController, destination: IntrestingEventsController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // открыть следующий город по тыку на ячееке с городами
    func navigateToViewContact(source: CurrentCityController, destination: CityController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    func navigateToExibitions(source: CurrentCityController!, destination: ExibitionsController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    func presentModalRentAuto(source: CurrentCityController!, destination: RentAutoController) {
        source.present(destination, animated: true, completion: nil)
    }
    
    // MARK: - Передача данных
    func passDataToIntrestingEvents(source: CurrentCityDataStore, destination: inout IntrestingEventsDataStore) {
        destination.currentCity = source.currentCity
    }
    
    func passDataToLeadMore(source: CurrentCityDataStore, destination: inout CityDataStore) {
        destination.currentCity = source.currentCity
    }
    
    func passDataToExibitions(source: CurrentCityDataStore, destination: inout ExibitionsDataStore) {
        destination.currentCity = source.currentCity
    }
}

