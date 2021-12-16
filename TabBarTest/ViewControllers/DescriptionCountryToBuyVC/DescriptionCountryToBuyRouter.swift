//
//  DescriptionCountryToBuyRouter.swift
//  TabBarTest
//
//  Created by ViceCode on 16.12.2021.
//

import Foundation

protocol DescriptionCountryToBuyRoutingLogic {
}

protocol DescriptionCountryToBuyDataPassing {
    var dataStore: DescriptionCountryToBuyDataStore? { get }
}

class DescriptionCountryToBuyRouter: NSObject, DescriptionCountryToBuyRoutingLogic, DescriptionCountryToBuyDataPassing {
    var dataStore: DescriptionCountryToBuyDataStore?
    weak var viewController: DescriptionCountryToBuyController?
    
}
