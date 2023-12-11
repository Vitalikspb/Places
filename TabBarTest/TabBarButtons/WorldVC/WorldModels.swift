//
//  WorldModels.swift
//  TabBarTest
//
//  Created by ViceCode on 14.12.2021.
//

import Foundation
import UIKit

struct TitleSection: Hashable {
    let country: String
    let subTitle: String
    let latitude: Double
    let longitude: Double
    let available: Bool
    let iconName: String
}

enum WorldViewModels {

    enum AllCountriesInTheWorld {

        // передаем в интерактор
        struct Request { }
        
        // передаем все города в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все города для отображения на экране
        struct ViewModel {
            var titlesec: TitleSection
            var model: [SightDescriptionResponce]?
        }
    }
}
