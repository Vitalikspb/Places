//
//  CurrentCityPresenter.swift
//  TabBarTest
//
//

import Foundation

protocol CurrentCityPresenterLogic: AnyObject {
    func presentCity(response: CurrentCityViewModel.CurrentCity.ViewModel,
                     viewModelCityData: CurrentCityViewModel.AllCountriesInTheWorld.ViewModel,
                     viewModelSightData: [Sight], otherCityData: [SightDescription])
    func updateWeather(response: CurrentCityViewModel.CurrentCity.ViewModel)
}

final class CurrentCityPresenter: CurrentCityPresenterLogic {
    
    weak var сurrentCityController: CurrentCityController?
    
    func presentCity(response: CurrentCityViewModel.CurrentCity.ViewModel, viewModelCityData: CurrentCityViewModel.AllCountriesInTheWorld.ViewModel, viewModelSightData: [Sight], otherCityData: [SightDescription]) {
        сurrentCityController?.displayCurrentCity(viewModelWeather: response,
                                           viewModelCityData: viewModelCityData,
                                           viewModelSightData: viewModelSightData,
                                                  otherCityData: otherCityData)
        
    }
    
    func updateWeather(response: CurrentCityViewModel.CurrentCity.ViewModel) {
        сurrentCityController?.updateWeather(viewModel: response)
    }
}
