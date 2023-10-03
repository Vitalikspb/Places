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
//    func routeToExibitionVC()
    func routeToRentAutoVC()
    func routeToFAQVC()
    func routeToHelperMapsVC()
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
    
    // показать модальный экран со списком компаний аренды автомобилей
    func routeToRentAutoVC() {
        let destination: RentAutoController = RentAutoController.loadFromStoryboard()
        presentModalRentAuto(source: viewController!, destination: destination)
    }
    func routeToFAQVC() {
        let destinationVC: FAQController = FAQController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToFaq(source: dataStore!, destination: &destinationDS)
        navigateToFaq(source: viewController!, destination: destinationVC)
    }
    // TODO - доделать роутинг
    func routeToHelperMapsVC() {
        let destinationVC: HelperMapsController = HelperMapsController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToHelperMaps(source: dataStore!, destination: &destinationDS)
        navigateToHelperMaps(source: viewController!, destination: destinationVC)
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
    // на экран билеты на экскурсию
//    func routeToExibitionVC() {
//        let destinationVC: ExibitionsController = ExibitionsController.loadFromStoryboard()
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToExibitions(source: dataStore!, destination: &destinationDS)
//        navigateToExibitions(source: viewController!, destination: destinationVC)
//    }

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
    

    
//    func navigateToExibitions(source: CityController!, destination: ExibitionsController) {
//        source.navigationController?.pushViewController(destination, animated: true)
//    }
    func navigateToHelperMaps(source: CityController, destination: HelperMapsController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    func presentModalRentAuto(source: CityController!, destination: RentAutoController) {
        source.present(destination, animated: true, completion: nil)
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
        destination.currentCity = source.currentCity
    }
    
//    func passDataToExibitions(source: CityDataStore, destination: inout ExibitionsDataStore) {
//        destination.currentCity = source.currentCity
//    }
    func passDataToHelperMaps(source: CityDataStore, destination: inout HelperMapsDataStore) {
        destination.currentCity = source.currentCity
    }
    func passDataToFaq(source: CityDataStore, destination: inout FAQDataStore) {
        destination.currentCity = source.currentCity
    }

}
