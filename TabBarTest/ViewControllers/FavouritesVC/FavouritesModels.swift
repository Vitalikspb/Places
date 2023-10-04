//
//  FavouritesViewModel.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import Foundation
import UIKit


enum FavouritesViewModel {
    
    struct FavouritesViewModel: Hashable {
        var titlesec: TitleSection
        var items: [ItemData]
    }
    struct ItemData: Hashable {
        let name: String
        let type: String
        let image: UIImage
    }
    struct TitleSection: Hashable {
        let country: String
        let city: String
    }
    enum FavouritesSight {
        
        // передаем в интерактор
        struct Request { }
        
        // передаем все города в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все города для отображения на экране
        struct ViewModel {
            var model: [FavouritesViewModel]
        }
    }
    
}
