//
//  HelperMapsRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.12.2021.
//

import UIKit

protocol HelperMapsRoutingLogic: AnyObject {
    func routeToMapImageVC()
}

protocol HelperMapsDataPassing: AnyObject {
    var dataStore: HelperMapsDataStore? { get set }
}

class HelperMapsRouter: NSObject, HelperMapsRoutingLogic, HelperMapsDataPassing {
    
    weak var viewController: HelperMapsController?
    var dataStore: HelperMapsDataStore?
    
    // MARK: - Роутинг

    func routeToMapImageVC() {
        let destinationVC: MapImageController = MapImageController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMapImage(source: dataStore!, destination: &destinationDS)
        navigateToMapImage(source: viewController!, destination: destinationVC)
    }

    // MARK: - Навигация
    
    
    func navigateToMapImage(source: HelperMapsController, destination: MapImageController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Передача данных

    func passDataToMapImage(source: HelperMapsDataStore, destination: inout MapImageDataStore) {
        destination.nameOfMap = source.name
        destination.stringURLOfMap = source.stringURL
    }
}
