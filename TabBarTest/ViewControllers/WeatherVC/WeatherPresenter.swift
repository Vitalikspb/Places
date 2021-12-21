//
//  WeatherPresenter.swift
//  TabBarTest
//
//  Created by ViceCode on 21.12.2021.
//

import Foundation

protocol WeatherPresentationLogic {
    func presentWeather(response: WeatherModels.Weather.ViewModel)
}

final class WeatherPresenter: WeatherPresentationLogic {
    
    weak var weatherController: WeatherController?
    
    func presentWeather(response: WeatherModels.Weather.ViewModel) {
        weatherController?.displayWeather(viewModel: response)
    }
}
