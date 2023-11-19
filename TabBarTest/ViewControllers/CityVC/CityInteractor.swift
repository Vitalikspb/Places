//
//  CityInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit
import CoreLocation

protocol CityBussinessLogic: AnyObject {
    func showCity()
}

protocol CityDataStore: AnyObject {
    var currentCity: String { get set }
    var currentCountry: String { get set }
    var currentWeather: CurrentWeatherSevenDays { get set }
    var cityInfo: CityViewModel.AllCountriesInTheWorld.ViewModel { get set }
}

class CityInteractor: CityBussinessLogic, CityDataStore {
    var cityInfo: CityViewModel.AllCountriesInTheWorld.ViewModel = CityViewModel.AllCountriesInTheWorld.ViewModel(
        titlesec: TitleSection(country: "",
                               subTitle: "",
                               latitude: 0.0,
                               longitude: 0.0,
                               available: true,
                               iconName: ""),
        model: [])
    
    
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
                                                    let viewModel = CityViewModel.CurrentCity.ViewModel(
                                                        city: currentCity,
                                                        weather: currentWeather)
                                                    presenter?.updateWeather(response: viewModel)
                                                }
                                            }
    var currentCity: String = ""
    var currentCountry: String = ""
    var presenter: CityPresentationLogic?
    
    func showCity() {
        let viewModelWeather = CityViewModel.CurrentCity.ViewModel(city: currentCity, weather: currentWeather)
        let lat: CLLocationDegrees = cityInfo.model?[0].latitude ?? 0.0
        let lon: CLLocationDegrees = cityInfo.model?[0].longitude ?? 0.0
        
        print("lat:\(lat)---lon:\(lon)")
        
        updateWeather(latitude: lat, longitude: lon)
        presenter?.presentCity(response: viewModelWeather, viewModelCityData: cityInfo)
    }
    
    func updateWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        WeatherAPI().descriptionCurrentWeatherForSevenDays(latitude: latitude, longitude: longitude) { [weak self] weatherSevernDays in
            guard let self = self else { return }
            self.currentWeather = weatherSevernDays
            print("1 updateWeather currentWeather:\(currentWeather)")
            self.currentWeather.sevenDaysWeather.removeFirst()
        }
    }
}

