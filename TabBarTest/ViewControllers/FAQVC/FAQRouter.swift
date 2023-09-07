//
//  FAQRouter.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import Foundation

protocol FAQRoutingLogic: AnyObject {
}

protocol FAQDataPassing: AnyObject {
    var dataStore: FAQDataStore? { get }
}

class FAQRouter: NSObject, FAQRoutingLogic, FAQDataPassing {
    var dataStore: FAQDataStore?
    weak var viewController: FAQController?
    
}
