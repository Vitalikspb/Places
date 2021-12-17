//
//  BuyCountryModels.swift
//  TabBarTest
//
//

import Foundation
import UIKit

enum SelectedInterestingEventViewModel {
    
    struct EventModel {
        let nameEvent: String
        let mainText: String
        let image: [UIImage]
        let date: String
    }
    
    enum EventModels {

        // передаем в интерактор
        struct Request { }
        
        // передаем все города в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все города для отображения на экране
        struct ViewModel {
            var event: EventModel
        }
    }
}
