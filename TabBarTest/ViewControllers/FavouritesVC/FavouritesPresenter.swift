//
//  FavouritesPresenter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import Foundation

protocol FavouritesPresentationLogic {
    func presentFavourites(response: FavouritesViewModel.FavouritesSight.ViewModel)
}

final class FavouritesPresenter: FavouritesPresentationLogic {
    weak var favouritesController: FavouritesController?
    
    func presentFavourites(response: FavouritesViewModel.FavouritesSight.ViewModel) {
        let viewModel = response
        favouritesController?.displayFavourites(viewModel: viewModel)
    }
    
}
