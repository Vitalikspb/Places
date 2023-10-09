//
//  CountryRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol CurrentCityRoutingLogic: AnyObject {
    func routeToCityVC()
    func routeToFavouritesVC()
    func routeToInterestingEventsVC()
    func routeToFAQVC()
    func routeToFullWeatherVC()
}

protocol CurrentCityDataPassing: AnyObject {
    var dataStore: CurrentCityDataStore? { get set }
}

class CurrentCityRouter: NSObject, CurrentCityRoutingLogic, CurrentCityDataPassing {
    
    weak var viewController: CurrentCityController?
    var dataStore: CurrentCityDataStore?
    
    // MARK: - Роутинг
    
    func routeToFullWeatherVC() {
        let destinationVC: WeatherController = WeatherController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToFullWeather(source: dataStore!, destination: &destinationDS)
        navigateToFullWeather(source: viewController!, destination: destinationVC)
    }

    func routeToFAQVC() {
        let destinationVC: FAQController = FAQController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToFaq(source: dataStore!, destination: &destinationDS)
        navigateToFaq(source: viewController!, destination: destinationVC)
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

    // MARK: - Навигация
    
    func navigateToFullWeather(source: CurrentCityController, destination: WeatherController) {
        source.present(destination, animated: true, completion: nil)
    }
    
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

    func navigateToFaq(source: CurrentCityController!, destination: FAQController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Передача данных
    
    func passDataToFullWeather(source: CurrentCityDataStore, destination: inout WeatherDataStore) {
        destination.currentCity = source.currentCity
        destination.currentWeather = source.currentWeather
    }
    
    func passDataToIntrestingEvents(source: CurrentCityDataStore, destination: inout IntrestingEventsDataStore) {
        destination.currentCity = source.currentCity
    }
    
    func passDataToLeadMore(source: CurrentCityDataStore, destination: inout CityDataStore) {
        destination.currentCity = source.currentCity
    }
    
    func passDataToFaq(source: CurrentCityDataStore, destination: inout FAQDataStore) {
        destination.currentCity = source.currentCity
    }
}

