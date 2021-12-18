//
//  HelperMapsRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.12.2021.
//

import Foundation

protocol HelperMapsRoutingLogic {
}

protocol HelperMapsDataPassing {
    var dataStore: HelperMapsDataStore? { get }
}

class HelperMapsRouter: NSObject, HelperMapsRoutingLogic, HelperMapsDataPassing {
    var dataStore: HelperMapsDataStore?
    weak var viewController: HelperMapsController?
    
}
