//
//  WorldModels.swift
//  TabBarTest
//
//  Created by ViceCode on 14.12.2021.
//

import Foundation
import UIKit

enum WorldViewModels {
    
    struct WorldViewModel: Hashable {
        var titlesec: TitleSection
        var items: [ItemData]
    }
    struct ItemData: Hashable {
        let name: String
        let sights: Int
        let imageCity: UIImage
    }
    struct TitleSection: Hashable {
        let name: String
        let subName: String
        let iconCountry: UIImage
        let available: Bool
    }
    enum AllCountriesInTheWorld {

        // передаем в интерактор
        struct Request { }
        
        // передаем все города в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все города для отображения на экране
        struct ViewModel {
            var model: [WorldViewModel]
        }
    }
}
