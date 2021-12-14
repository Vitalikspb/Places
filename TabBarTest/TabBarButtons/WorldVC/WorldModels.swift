//
//  WorldModels.swift
//  TabBarTest
//
//  Created by ViceCode on 14.12.2021.
//

import Foundation
import UIKit

enum WorldViewModels {
    
    struct WorldModel {
        let name: String
        let image: UIImage
    }
    
    enum AllCountriesInTheWorld {

        // передаем в интерактор
        struct Request { }
        
        // передаем все города в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все города для отображения на экране
        struct ViewModel {
            var country: [WorldModel]
        }
    }
}
