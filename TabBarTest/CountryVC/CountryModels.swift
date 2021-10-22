//
//  CountryModels.swift
//  TabBarTest
//
//  Created by ViceCode on 21.10.2021.
//

import Foundation

import UIKit

enum CountryViewModel {
    
    struct CityModel {
        let name: String
        let image: UIImage
    }
    
    enum AllCitiesInCurrentCountry {

        // передаем в интерактор
        struct Request { }
        
        // передаем все города в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все города для отображения на экране
        struct ViewModel {
            var cities: [CityModel]
        }
    }
}