//
//  FAQModels.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import Foundation

import Foundation
import UIKit

enum FAQModels {
    
    struct FAQModel {
        var question: String
        var answer: String
    }

    enum FAQModels {

        // передаем в интерактор
        struct Request { }
        
        // передаем выбранный город в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все описание текущего города который выбрали из вкладки CountyTab
        struct ViewModel {
            var currentCity: String
            var FAQModel: [FAQModel]
        }
    }
}
