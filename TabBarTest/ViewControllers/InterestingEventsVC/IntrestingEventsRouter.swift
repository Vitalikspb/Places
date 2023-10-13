//
//  IntrestingEventsRouter.swift
//  TabBarTest
//
//  Created by ViceCode on 14.12.2021.
//

import Foundation

protocol IntrestingEventsRoutingLogic: AnyObject {
    func routeToSelectedEventVC()
}

protocol IntrestingEventsDataPassing: AnyObject {
    var dataStore: IntrestingEventsDataStore? { get set }
}

class IntrestingEventsRouter: NSObject, IntrestingEventsRoutingLogic, IntrestingEventsDataPassing {
    
    // MARK: - Public properties
    
    var dataStore: IntrestingEventsDataStore?
    weak var viewController: IntrestingEventsController?
    
    // MARK: - Роутинг
    
    func routeToSelectedEventVC() {
        let destinationVC: SelectedInterestingEventController = SelectedInterestingEventController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        let sourse = Events(id: 0,
                            name: "",
                            description: "",
                            country: dataStore?.country ?? "Россия",
                            city: dataStore?.city ?? "Москва",
                            date: "")
        passDataToLeadMore(source: sourse, destination: &destinationDS)
        navigateToViewContact(source: viewController!, destination: destinationVC)
    }

    // MARK: - Навигация
    
    // открыть следующий город по тыку на ячееке с городами
    func navigateToViewContact(source: IntrestingEventsController, destination: SelectedInterestingEventController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Передача данных
    
    func passDataToLeadMore(source: Events, destination: inout SelectedInterestingEventDataStore) {
        destination.name = source.name
        destination.date = source.date
        destination.description = source.description
        destination.images = source.images
    }
}
