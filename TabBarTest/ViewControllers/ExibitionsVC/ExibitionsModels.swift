//
//  ExibitionsModels.swift
//  TabBarTest
//
//  Created by ViceCode on 14.12.2021.
//

import Foundation
import UIKit

enum ExibitionsModels {
    
    struct ExibitionsModel {
        let image: UIImage
        let name: String
        let reviewsStar: Int
        let reviewsCount: Int
        let price: Int
        let duration: String
    }
    
    enum Exibitions {

        // передаем в интерактор
        struct Request { }
        
        // передаем все города в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все интеренсые события для отображения на экране
        struct ViewModel {
            var events: [ExibitionsModel]
        }
    }
}
