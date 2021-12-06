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
    weak var FavouritesController: FavouritesController?
    
    func presentFavourites(response: FavouritesViewModel.FavouritesSight.ViewModel) {
        let viewModel = response
        FavouritesController?.displayFavourites(viewModel: viewModel)
    }
    
}
