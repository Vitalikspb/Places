//
//  FavouritesInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol FavouritesBussinessLogic {
    func showFavourites()
}
//
//protocol FavouritesDataStore {
//    var citiesArray: [String] { get set }
//}

class FavouritesInteractor: FavouritesBussinessLogic {
    
    var presenter: FavouritesPresentationLogic?
    
    func showFavourites() {
        // создаем модель из БД из избранного
        
        // все достопримечательности для длинного списка на самом верху экрана - бесконечная лента из достопримечательностей
        let allFavourites = [
            FavouritesViewModel.FavouritesSight.FavouritesAllCitiesModel(
                city: "Санкт-Петербург",
                image: UIImage(named: "hermitage5")!,
                nameOfSight: "Эрмитаж",
                sightFavouritesFlag: true),
            FavouritesViewModel.FavouritesSight.FavouritesAllCitiesModel(
                city: "Санкт-Петербург",
                image: UIImage(named: "museumRusskiy")!,
                nameOfSight: "Русский музей",
                sightFavouritesFlag: true),
            FavouritesViewModel.FavouritesSight.FavouritesAllCitiesModel(
                city: "Москва",
                image: UIImage(named: "savered")!,
                nameOfSight: "Красная площадь",
                sightFavouritesFlag: true),
            FavouritesViewModel.FavouritesSight.FavouritesAllCitiesModel(
                city: "Москва",
                image: UIImage(named: "savelenin")!,
                nameOfSight: "Мавзолей",
                sightFavouritesFlag: true),
            FavouritesViewModel.FavouritesSight.FavouritesAllCitiesModel(
                city: "Стамбул",
                image: UIImage(named: "savebosfor")!,
                nameOfSight: "Босфор",
                sightFavouritesFlag: true)
        ]
        
        
        
        // для заполнения таблицы
        
        let cityMoscowSight = [
            FavouritesViewModel.FavouritesSight.CitySight(
                sightType: "Музей",
                sightName: "Мавзолей",
                sightImage: UIImage(named: "savelenin")!,
                sightFavouritesFlag: true),
            FavouritesViewModel.FavouritesSight.CitySight(
                sightType: "Музей",
                sightName: "Красная площадь",
                sightImage: UIImage(named: "savered")!,
                sightFavouritesFlag: true)
        ]
        
        let citySpbSight = [
            FavouritesViewModel.FavouritesSight.CitySight(
                sightType: "Музей",
                sightName: "Эрмитаж",
                sightImage: UIImage(named: "hermitage5")!,
                sightFavouritesFlag: true),
            FavouritesViewModel.FavouritesSight.CitySight(
                sightType: "Музей",
                sightName: "Русский музей",
                sightImage: UIImage(named: "museumRusskiy")!,
                sightFavouritesFlag: true)
        ]
        
        let listFavouritesSightRussia = [
            FavouritesViewModel.FavouritesSight.FovouritesCitiesModel(
                city: "Москва",
                citySight: cityMoscowSight),
            FavouritesViewModel.FavouritesSight.FovouritesCitiesModel(
                city: "Санкт-Петербург",
                citySight: citySpbSight)
        ]
        
        
        let cityStambulSight = [
            FavouritesViewModel.FavouritesSight.CitySight(
                sightType: "Музей",
                sightName: "Босфор",
                sightImage: UIImage(named: "savebosfor")!,
                sightFavouritesFlag: true),
        ]
        let listFavouritesSightTurkish = [
            FavouritesViewModel.FavouritesSight.FovouritesCitiesModel(
                city: "Стамбул",
                citySight: cityStambulSight)
        ]
        
        
        let countyFavourites = [
            FavouritesViewModel.FavouritesSight.FavouritesSightModel(
                county: "Россия",
                city: listFavouritesSightRussia),
            FavouritesViewModel.FavouritesSight.FavouritesSightModel(
                county: "Турция",
                city: listFavouritesSightTurkish),
        ]
        
        let viewModel = FavouritesViewModel.FavouritesSight.ViewModel(
            allSight: allFavourites,
            county: countyFavourites)
        presenter?.presentFavourites(response: viewModel)
    }
}

