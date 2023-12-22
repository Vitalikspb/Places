//
//  CurrentCityPresenter.swift
//  TabBarTest
//
//

import Foundation

protocol CurrentCityPresenterLogic: AnyObject {
    func presentCity(response: CurrentCityViewModel.CurrentCity.ViewModel,
                     viewModelCityData: CurrentCityViewModel.AllCountriesInTheWorld.ViewModel,
                     viewModelSightData: [Sight], otherCityData: [SightDescriptionResponce])
    func updateWeather(response: CurrentCityViewModel.CurrentCity.ViewModel)
    func showSelectCity()
}

final class CurrentCityPresenter: CurrentCityPresenterLogic {
    
    weak var сurrentCityController: CurrentCityController?
    
    func presentCity(response: CurrentCityViewModel.CurrentCity.ViewModel, viewModelCityData: CurrentCityViewModel.AllCountriesInTheWorld.ViewModel, viewModelSightData: [Sight], otherCityData: [SightDescriptionResponce]) {
        сurrentCityController?.displayCurrentCity(viewModelWeather: response,
                                           viewModelCityData: viewModelCityData,
                                           viewModelSightData: viewModelSightData,
                                                  otherCityData: otherCityData)
        
    }
    
    func updateWeather(response: CurrentCityViewModel.CurrentCity.ViewModel) {
        сurrentCityController?.updateWeather(viewModel: response)
    }
    
    func showSelectCity() {
        сurrentCityController?.showSelectCity()
    }
}
