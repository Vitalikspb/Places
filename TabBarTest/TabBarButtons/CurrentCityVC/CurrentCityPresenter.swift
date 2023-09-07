//
//  CurrentCityPresenter.swift
//  TabBarTest
//
//

import Foundation

protocol CurrentCityPresentationLogic: AnyObject {
    func presentAllMarkers(response: CurrentCityViewModel.AllCitiesInCurrentCountry.ViewModel)
    func updateWeather(response: CurrentCityViewModel.WeatherCurrentCountry.ViewModel)
}

final class CurrentCityPresenter: CurrentCityPresentationLogic {
    weak var currentCityController: CurrentCityController?
    
    func presentAllMarkers(response: CurrentCityViewModel.AllCitiesInCurrentCountry.ViewModel) {
        currentCityController?.displayAllCities(viewModel: response)
    }
    
    func updateWeather(response: CurrentCityViewModel.WeatherCurrentCountry.ViewModel) {
        currentCityController?.updateWeather(viewModel: response)
    }
    
}
