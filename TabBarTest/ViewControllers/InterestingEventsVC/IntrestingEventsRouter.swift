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
        passDataToLeadMore(source: dataStore!, destination: &destinationDS)
        navigateToViewContact(source: viewController!, destination: destinationVC)
    }

    // MARK: - Навигация
    
    // открыть следующий город по тыку на ячееке с городами
    func navigateToViewContact(source: IntrestingEventsController, destination: SelectedInterestingEventController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Передача данных
    
    func passDataToLeadMore(source: IntrestingEventsDataStore, destination: inout SelectedInterestingEventDataStore) {
        destination.name = source.name
        destination.image = source.image
        destination.description = source.description
        destination.date = source.date
    }
}
