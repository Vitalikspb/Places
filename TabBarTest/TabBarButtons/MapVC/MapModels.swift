//
//  MapViewModel.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 04.10.2021.
//

import Foundation


import UIKit
import GoogleMaps

enum MapViewModel {
    
    // фильтры маркеров на карте
    enum FilterName {
        case All
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
            let markers: [GMSMarker]
        }
        
        // для открытия floating view по нажатию на метку на экране
        struct ViewModel {
            let markers: [GMSMarker]
        }
    }
}


struct CurrentMarkerInfo {
    let name: String
}
