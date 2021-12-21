//
//  WeatherRouter.swift
//  TabBarTest
//
//  Created by ViceCode on 21.12.2021.
//

import Foundation

protocol WeatherRoutingLogic {
}

protocol WeatherDataPassing {
    var dataStore: WeatherDataStore? { get }
}

class WeatherRouter: NSObject, WeatherRoutingLogic, WeatherDataPassing {
    var dataStore: WeatherDataStore?
    weak var viewController: WeatherController?
    
}
