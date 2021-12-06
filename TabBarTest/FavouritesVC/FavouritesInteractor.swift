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
                image: UIImage(systemName: "gear")!,
                nameOfSight: "Эрмитаж"),
            FavouritesViewModel.FavouritesSight.FavouritesAllCitiesModel(
                city: "Москва",
                image: UIImage(systemName: "gear")!,
                nameOfSight: "Красная площадь"),
            FavouritesViewModel.FavouritesSight.FavouritesAllCitiesModel(
                city: "Москва",
                image: UIImage(systemName: "gear")!,
                nameOfSight: "Мавзолей ленина"),
        FavouritesViewModel.FavouritesSight.FavouritesAllCitiesModel(
            city: "Стамбул",
            image: UIImage(systemName: "gear")!,
            nameOfSight: "Босфор")
        ]
        
        // для заполнения таблицы
        let listFavouritesSightRussia = [
            FavouritesViewModel.FavouritesSight.FovouritesCitiesModel(
                nameSight: "Эрммитаж",
                imageSing: UIImage(systemName: "gear")!,
                favouritesMark: true),
            FavouritesViewModel.FavouritesSight.FovouritesCitiesModel(
                nameSight: "Красная площадь",
                imageSing: UIImage(systemName: "gear")!,
                favouritesMark: true),
            FavouritesViewModel.FavouritesSight.FovouritesCitiesModel(
                nameSight: "Мавзолей ленина",
                imageSing: UIImage(systemName: "gear")!,
                favouritesMark: true),
        ]
        let listFavouritesSightTurkish = [
            FavouritesViewModel.FavouritesSight.FovouritesCitiesModel(
                nameSight: "Босфор",
                imageSing: UIImage(systemName: "gear")!,
                favouritesMark: true)
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

