//
//  FavouritesInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol FavouritesBussinessLogic: AnyObject {
    func showFavourites()
    func updateFavorites(withName name: String)
    var sights: [Sight] { get set }
}

class FavouritesInteractor: FavouritesBussinessLogic {
    var sights: [Sight] = []
    var presenter: FavouritesPresentationLogic?
    
    func showFavourites() {
        // создаем модель из БД из избранного
        
        sights = UserDefaults.standard.getFavorites()
        var uniqueCities = [String]()
        
        sights.forEach {
            uniqueCities.append($0.city)
        }
        
        uniqueCities = Array(Set(uniqueCities))
        var tempModel = [FavouritesViewModel.FavouritesViewModel]()
        
        
        for (_,valUniqueCity) in uniqueCities.enumerated() {
            var tempSights = [Sight]()
            var tempCity = ""
            
            for (indFavorite,valFavorite) in sights.enumerated() {
                if valFavorite.city == valUniqueCity {
                    tempSights.append(sights[indFavorite])
                    tempCity = valUniqueCity
                }
            }
            
            let titleModel = FavouritesViewModel.TitleSection(country: "Россия", city: tempCity)
            tempModel.append(FavouritesViewModel.FavouritesViewModel(titlesec: titleModel, items: tempSights))
        }
        let viewModel = FavouritesViewModel.FavouritesSight.ViewModel(model: tempModel)
        presenter?.presentFavourites(response: viewModel)
    }
    
    func updateFavorites(withName name: String) {
        ManagesFavorites.updateFavorites(sights: &sights, withName: name)
        showFavourites()
        if sights.count == 0 {
            presenter?.dismissScreen()
        }
    }
    
}

