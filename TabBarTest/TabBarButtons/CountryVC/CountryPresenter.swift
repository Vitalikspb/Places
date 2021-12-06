//
//  CountryPresenter.swift
//  TabBarTest
//
//

import Foundation

protocol CountryPresentationLogic {
    func presentAllMarkers(response: CountryViewModel.AllCitiesInCurrentCountry.ViewModel)
}

final class CountryPresenter: CountryPresentationLogic {
    weak var CountryController: CountryController?
    
    func presentAllMarkers(response: CountryViewModel.AllCitiesInCurrentCountry.ViewModel) {
        CountryController?.displayAllCities(viewModel: response)
    }
    
}
