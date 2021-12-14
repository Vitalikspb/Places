//
//  FavouritesViewModel.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import Foundation
import UIKit

protocol IFavouritesAllCitiesModel {
    var city: String { get }
    var image: UIImage { get }
    var nameOfSight: String { get }
    var sightFavouritesFlag: Bool { get }
}

enum FavouritesViewModel {
    
    enum FavouritesSight {

        // передаем в интерактор
        struct Request { }
        
        // передаем модель всех городов из избранного в перезнтер для последующего отображения на экране
        struct Response {
            var allSight: [FavouritesAllCitiesModel]
            var ListSight: [FavouritesSightModel]
        }
        
        struct FavouritesAllCitiesModel: IFavouritesAllCitiesModel {
            var city: String
            var image: UIImage
            var nameOfSight: String
            var sightFavouritesFlag: Bool
        }

        struct FavouritesSightModel {
            var county: String
            var city: [FovouritesCitiesModel]
        }
        struct FovouritesCitiesModel {
            var city: String
            var citySight: [CitySight]
        }
        struct CitySight {
            var sightType: String
            var sightName: String
            var sightImage: UIImage
            var sightFavouritesFlag: Bool
        }
        
        // посылаем все города для отображения на экране
        struct ViewModel {
            var allSight: [IFavouritesAllCitiesModel]
            var county: [FavouritesSightModel]
        }
    }
}
