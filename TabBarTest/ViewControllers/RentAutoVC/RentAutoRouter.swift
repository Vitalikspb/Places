//
//  RentAutoRouter.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import Foundation

protocol RentAutoRoutingLogic {
}

protocol RentAutoDataPassing {
    var dataStore: RentAutoDataStore? { get }
}

class RentAutoRouter: NSObject, RentAutoRoutingLogic, RentAutoDataPassing {
    var dataStore: RentAutoDataStore?
    weak var viewController: RentAutoController?
    
}
