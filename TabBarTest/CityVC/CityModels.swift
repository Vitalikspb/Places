//
//  CityModels.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import Foundation

import UIKit

enum CityViewModel {
    
    struct CityModel {
        let title: String
        let image: UIImage
    }
    
    enum CurrentCity {

        // передаем в интерактор
        struct Request { }
        
        // передаем все города в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все города для отображения на экране
        struct ViewModel {
            var city: CityModel
        }
    }
}
