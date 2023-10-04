//
//  FavouritesInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol FavouritesBussinessLogic: AnyObject {
    func showFavourites()
}
//
//protocol FavouritesDataStore: AnyObject {
//    var citiesArray: [String] { get set }
//}

class FavouritesInteractor: FavouritesBussinessLogic {
    
    var presenter: FavouritesPresentationLogic?
    
    func showFavourites() {
        // создаем модель из БД из избранного

        

        let viewModel = FavouritesViewModel.FavouritesSight.ViewModel(
            model: [FavouritesViewModel.FavouritesViewModel(titlesec: FavouritesViewModel.TitleSection(country: "Россия",
                                                                                                       city: "Санкт-Петербург"),
                                                            items: [FavouritesViewModel.ItemData(name: "Эрмитаж",
                                                                                                 type: "Музей",
                                                                                                 image: UIImage(named: "hermitage5")!),
                                                                    FavouritesViewModel.ItemData(name: "Русский музей",
                                                                                                 type: "музей",
                                                                                                 image: UIImage(named: "museumRusskiy")!),
                                                                    FavouritesViewModel.ItemData(name: "Купчино",
                                                                                                 type: "район",
                                                                                                 image: UIImage(named: "savered")!)]),
                    
                    FavouritesViewModel.FavouritesViewModel(titlesec: FavouritesViewModel.TitleSection(country: "Россия",
                                                                                                       city: "Москва"),
                                                                    items: [FavouritesViewModel.ItemData(name: "Красная площадь",
                                                                                                         type: "площадь",
                                                                                                         image: UIImage(named: "hermitage5")!),
                                                                            FavouritesViewModel.ItemData(name: "Арбат",
                                                                                                         type: "место",
                                                                                                         image: UIImage(named: "savebosfor")!),
                                                                            FavouritesViewModel.ItemData(name: "Мавзолей ленина",
                                                                                                         type: "мавзолей",
                                                                                                         image: UIImage(named: "savelenin")!)]),
                   ])
        presenter?.presentFavourites(response: viewModel)
    }
}

