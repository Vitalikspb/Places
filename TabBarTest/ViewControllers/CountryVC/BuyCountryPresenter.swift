//
//  BuyCountryPresenter.swift
//  TabBarTest
//
//

import Foundation

protocol BuyCountryPresentationLogic {
    func presentAllMarkers(response: BuyCountryViewModel.AllCitiesInCurrentCountry.ViewModel)
}

final class BuyCountryPresenter: BuyCountryPresentationLogic {
    weak var buyCountryController: BuyCountryController?
    
    func presentAllMarkers(response: BuyCountryViewModel.AllCitiesInCurrentCountry.ViewModel) {
        buyCountryController?.displayAllCities(viewModel: response)
    }
    
}
