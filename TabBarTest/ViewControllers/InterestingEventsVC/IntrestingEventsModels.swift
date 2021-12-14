//
//  IntrestingEventsModels.swift
//  TabBarTest
//
//  Created by ViceCode on 14.12.2021.
//

import Foundation
import UIKit

enum IntrestingEventsModels {
    
    struct IntrestingEventsModel {
        let image: [UIImage]
        let name: String
        let descriptions: String
        let date: String
    }
    
    enum IntrestingEvents {

        // передаем в интерактор
        struct Request { }
        
        // передаем все города в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все интеренсые события для отображения на экране
        struct ViewModel {
            var events: [IntrestingEventsModel]
        }
    }
}
