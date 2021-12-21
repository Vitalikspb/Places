//
//  WeatherInteractor.swift
//  TabBarTest
//
//  Created by ViceCode on 21.12.2021.
//

import UIKit

protocol WeatherBussinessLogic {
    func showWeather()
}

protocol WeatherDataStore {
    var currentWeather: CurrentWeatherSevenDays { get set }
    var currentCity: String { get set }
}

class WeatherInteractor: WeatherBussinessLogic, WeatherDataStore {
    
    var currentCity: String = ""
    var currentWeather: CurrentWeatherSevenDays = CurrentWeatherSevenDays(
        currentWeather: CurrentWeatherOfSevenDays(todayTemp: 0.0,
                                                  imageWeather: UIImage(),
                                                  description: "",
                                                  feelsLike: 0.0,
                                                  sunrise: 0,
                                                  sunset: 0),
        sevenDaysWeather: [WeatherSevenDays(dayOfWeek: 0,
                                            tempFrom: 0.0,
                                            tempTo: 0.0,
                                            image: UIImage(),
                                            description: "")])
    var presenter: WeatherPresentationLogic?
    
    func showWeather() {
        presenter?.presentWeather(response: WeatherModels.Weather.ViewModel(currentCity: currentCity, weather: currentWeather))
    }
}
