//
//  UnboardingRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 07.12.2023.
//

import Foundation

protocol UnboardingRoutingLogic: AnyObject {
    func routeToMapVC()
}

protocol UnboardingDataPassing: AnyObject {
    var dataStore: UnboardingDataStore? { get }
}

class UnboardingRouter: NSObject, UnboardingRoutingLogic, UnboardingDataPassing {

    var dataStore: UnboardingDataStore?
    weak var viewController: UnboardingController?
    
    // Возврат на экран карты
    func routeToMapVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
