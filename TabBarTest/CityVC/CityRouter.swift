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
}

class CityRouter: NSObject, CityRoutingLogic, CityDataPassing {
    
  weak var viewController: CityController?
    
}
