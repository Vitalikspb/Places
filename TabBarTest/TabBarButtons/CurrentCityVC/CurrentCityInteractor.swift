//
//  CurrentCityInteractor.swift
//  TabBarTest
//
//

import UIKit
import CoreLocation

protocol CurrentCityBussinessLogic {
    func showCity(lat: CLLocationDegrees, lon: CLLocationDegrees)
}

protocol CurrentCityDataStore {
    var currentCity: String { get set }
    var currentWeather: CurrentWeatherSevenDays { get set }
}

class CurrentCityInteractor: CurrentCityBussinessLogic, CurrentCityDataStore {
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
    var currentCity: String = ""
    
    var presenter: CurrentCityPresentationLogic?
    
    func showCity(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        //        Здесь создаем модель для текукщего города - заполняем модель все информацией -
        //        погодой,
        //        главными картинкам,
        //        описанием
        //        ссылками кнопок
        //        местами
        //        другими городами
        //        по этой модели будем заполнять экран а не как сейчас
        
        let viewModel = CurrentCityViewModel.AllCitiesInCurrentCountry.ViewModel(
            weather: currentWeather,
            cities: CurrentCityViewModel.CityModel(name: currentCity, image: UIImage()))
        updateWeather(latitude: lat, longitude: lon)
        presenter?.presentAllMarkers(response: viewModel)
    }
    
    func updateWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        DispatchQueue.main.async {
            WeatherAPI().descriptionCurrentWeatherForSevenDays(latitude: latitude, longitude: longitude) { [weak self] weatherSevernDays in
                guard let self = self else { return }
                self.currentWeather = weatherSevernDays
            }
        }
    }
}

