//
//  WeatherRouter.swift
//  TabBarTest
//
//  Created by ViceCode on 21.12.2021.
//

import Foundation

protocol WeatherRoutingLogic: AnyObject {
}

protocol WeatherDataPassing: AnyObject {
    var dataStore: WeatherDataStore? { get }
}

class WeatherRouter: NSObject, WeatherRoutingLogic, WeatherDataPassing {
    var dataStore: WeatherDataStore?
    weak var viewController: WeatherController?
    
}
