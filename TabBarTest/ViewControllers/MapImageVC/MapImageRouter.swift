//
//  MapImageRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.12.2021.
//

import Foundation

protocol MapImageRoutingLogic {
}

protocol MapImageDataPassing {
    var dataStore: MapImageDataStore? { get }
}

class MapImageRouter: NSObject, MapImageRoutingLogic, MapImageDataPassing {
    var dataStore: MapImageDataStore?
    weak var viewController: MapImageController?
    
}
