//
//  CurrentCityPresenter.swift
//  TabBarTest
//
//

import Foundation

protocol CurrentCityPresenterLogic: AnyObject {
    func presentCity(response: CurrentCityViewModel.CurrentCity.ViewModel,
                     viewModelCityData: CurrentCityViewModel.AllCountriesInTheWorld.ViewModel,
                     viewModelSightData: [Sight])
    func updateWeather(response: CurrentCityViewModel.CurrentCity.ViewModel)
}

final class CurrentCityPresenter: CurrentCityPresenterLogic {
    
    weak var сurrentCityController: CurrentCityController?
    
    func presentCity(response: CurrentCityViewModel.CurrentCity.ViewModel, viewModelCityData: CurrentCityViewModel.AllCountriesInTheWorld.ViewModel, viewModelSightData: [Sight]) {
        сurrentCityController?.displayCurrentCity(viewModelWeather: response,
                                           viewModelCityData: viewModelCityData,
                                           viewModelSightData: viewModelSightData)
        
    }
    
    func updateWeather(response: CurrentCityViewModel.CurrentCity.ViewModel) {
        сurrentCityController?.updateWeather(viewModel: response)
    }
}
