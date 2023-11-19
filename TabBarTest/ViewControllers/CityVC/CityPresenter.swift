//
//  CityPresenter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import Foundation

protocol CityPresentationLogic: AnyObject {
    func presentCity(response: CityViewModel.CurrentCity.ViewModel, viewModelCityData: CityViewModel.AllCountriesInTheWorld.ViewModel)
    func updateWeather(response: CityViewModel.CurrentCity.ViewModel)
}

final class CityPresenter: CityPresentationLogic {
    
    weak var cityController: CityController?
    
    func presentCity(response: CityViewModel.CurrentCity.ViewModel, viewModelCityData: CityViewModel.AllCountriesInTheWorld.ViewModel) {
        cityController?.displayCurrentCity(viewModelWeather: response, viewModelCityData: viewModelCityData)
    }
    
    func updateWeather(response: CityViewModel.CurrentCity.ViewModel) {
        cityController?.updateWeather(viewModel: response)
    }
}
