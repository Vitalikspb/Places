//
//  CityRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import Foundation

protocol CityRoutingLogic {
}

protocol CityDataPassing {
    var dataStore: CityDataStore? { get }
}

class CityRouter: NSObject, CityRoutingLogic, CityDataPassing {
    var dataStore: CityDataStore?
    weak var viewController: CityController?
    
}
