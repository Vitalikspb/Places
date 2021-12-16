//
//  ExibitionsRouter.swift
//  TabBarTest
//
//  Created by ViceCode on 14.12.2021.
//

import Foundation

protocol ExibitionsRoutingLogic {
}

protocol ExibitionsDataPassing {
    var dataStore: ExibitionsDataStore? { get }
}

class ExibitionsRouter: NSObject, ExibitionsRoutingLogic, ExibitionsDataPassing {
    var dataStore: ExibitionsDataStore?
    
    
  weak var viewController: ExibitionsController?
    
}
