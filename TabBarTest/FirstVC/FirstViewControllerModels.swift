//
//  FirstViewControllerModels.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 04.10.2021.
//

import Foundation


import UIKit

enum MapViewModel {
    
    enum FilterName {
        case Alltest
        case AllRelease
        case Museum
        case Park
        case POI
        case Beach
    }
    
    enum ChoosenDestinationView {
        
        // передаем в интерактор название маркера для последующей обработки
        struct Request {
            let marker: String
        }
        
        // передаем модель маркера с полной инфой по маркеру для последующего отображения на экране в floating view
        struct Response {
            let destinationName: CurrentMarkerInfo
        }
        
        // для открытия floating view по нажатию на метку на экране
        struct ViewModel {
            let destinationName: String
        }
    }
}


struct CurrentMarkerInfo {
    let name: String
}
