//
//  FavouritesViewModel.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import Foundation

import UIKit

enum FavouritesViewModel {
    
    enum FavouritesSight {

        // передаем в интерактор
        struct Request { }
        
        // передаем модель всех городов из избранного в перезнтер для последующего отображения на экране
        struct FavouritesAllCitiesModel {
            var city: String
            var image: UIImage
            var nameOfSight: String
        }
        struct FovouritesCitiesModel {
            var nameSight: String
            var imageSing: UIImage
            var favouritesMark: Bool
        }
        struct FavouritesSightModel {
            var county: String
            var city: [FovouritesCitiesModel]
        }
        
        struct Response {
            var allSight: [FavouritesAllCitiesModel]
            var ListSight: [FavouritesSightModel]
        }
        
        // посылаем все города для отображения на экране
        struct ViewModel {
            var allSight: [FavouritesAllCitiesModel]
            var county: [FavouritesSightModel]
        }
    }
}
