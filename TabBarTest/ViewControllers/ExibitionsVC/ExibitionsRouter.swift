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
}

class ExibitionsRouter: NSObject, ExibitionsRoutingLogic, ExibitionsDataPassing {
    
  weak var viewController: ExibitionsController?
    
}
