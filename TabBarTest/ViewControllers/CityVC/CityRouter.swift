//
//  CityRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import Foundation

protocol CityRoutingLogic: AnyObject {
    func routeToFavouritesVC()
    func routeToInterestingEventsVC()
    func routeToFAQVC()
    func routeToFullWeatherVC()
}

protocol CityDataPassing: AnyObject {
    var dataStore: CityDataStore? { get }
}

class CityRouter: NSObject, CityRoutingLogic, CityDataPassing {
    var dataStore: CityDataStore?
    weak var viewController: CityController?
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

    // MARK: - Навигация
    
    func navigateToFullWeather(source: CityController, destination: WeatherController) {
        source.present(destination, animated: true, completion: nil)
    }
    
    // открыть избранное
    func navigateToFavourites(source: CityController, destination: FavouritesController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    // Открыть интересные события
    func navigateToIntrestingEvents(source: CityController, destination: IntrestingEventsController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    func navigateToFaq(source: CityController!, destination: FAQController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Передача данных
    
    func passDataToFullWeather(source: CityDataStore, destination: inout WeatherDataStore) {
        destination.currentCity = source.currentCity
        destination.currentWeather = source.currentWeather
    }
    
    func passDataToIntrestingEvents(source: CityDataStore, destination: inout IntrestingEventsDataStore) {
        destination.city = source.currentCity
        destination.country = source.currentCountry
    }
 
    func passDataToFaq(source: CityDataStore, destination: inout FAQDataStore) {
        destination.city = source.currentCity
        destination.country = source.currentCountry
    }

}
