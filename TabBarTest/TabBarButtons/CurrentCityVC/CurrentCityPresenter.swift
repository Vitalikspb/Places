//
//  CurrentCityPresenter.swift
//  TabBarTest
//
//

import Foundation

protocol CurrentCityPresentationLogic {
    func presentAllMarkers(response: CurrentCityViewModel.AllCitiesInCurrentCountry.ViewModel)
}

final class CurrentCityPresenter: CurrentCityPresentationLogic {
    weak var CurrentCityController: CurrentCityController?
    
    func presentAllMarkers(response: CurrentCityViewModel.AllCitiesInCurrentCountry.ViewModel) {
        CurrentCityController?.displayAllCities(viewModel: response)
    }
    
}
