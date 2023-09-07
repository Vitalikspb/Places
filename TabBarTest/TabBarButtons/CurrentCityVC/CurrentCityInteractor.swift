//
//  CurrentCityInteractor.swift
//  TabBarTest
//
//

import UIKit
import CoreLocation

protocol CurrentCityBussinessLogic: AnyObject {
    func showCity(lat: CLLocationDegrees, lon: CLLocationDegrees)
}

protocol CurrentCityDataStore: AnyObject {
    var currentCity: String { get set }
    var currentWeather: CurrentWeatherSevenDays { get set }
}

class CurrentCityInteractor: CurrentCityBussinessLogic, CurrentCityDataStore {
    
    // MARK: - Public properties
    
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
                                            description: "")]) {
                                                didSet {
                                                    let viewModel = CurrentCityViewModel.WeatherCurrentCountry.ViewModel(weather: currentWeather)
                                                    presenter?.updateWeather(response: viewModel)
                                                }
                                            }
    var currentCity: String = ""
    var presenter: CurrentCityPresentationLogic?
    
    // MARK: - CurrentCityBussinessLogic
    
    func showCity(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let viewModel = CurrentCityViewModel.AllCitiesInCurrentCountry.ViewModel(
            weather: currentWeather,
            cities: CurrentCityViewModel.CityModel(name: currentCity, image: UIImage()))
        updateWeather(latitude: lat, longitude: lon)
        presenter?.presentAllMarkers(response: viewModel)
    }
    
    // MARK: - Helper functions
    
    func updateWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        WeatherAPI().descriptionCurrentWeatherForSevenDays(latitude: latitude, longitude: longitude) { [weak self] weatherSevernDays in
            guard let self = self else { return }
            self.currentWeather = weatherSevernDays
            self.currentWeather.sevenDaysWeather.removeFirst()
        }
    }
}


