//
//  BuyCountryRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol SelectedInterestingEventRoutingLogic {
}

protocol SelectedInterestingEventDataPassing {
    var dataStore: SelectedInterestingEventDataStore? { get set }
}

class SelectedInterestingEventRouter: NSObject, SelectedInterestingEventRoutingLogic, SelectedInterestingEventDataPassing {
    
    weak var viewController: SelectedInterestingEventController?
    var dataStore: SelectedInterestingEventDataStore?
    
    // MARK: - Роутинг

    // MARK: - Навигация
    
    // MARK: - Передача данных
}

