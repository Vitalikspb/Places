//
//  DescriptionCountryToBuyInteractor.swift
//  TabBarTest
//
//  Created by ViceCode on 16.12.2021.
//

import UIKit
import CoreLocation

protocol DescriptionCountryToBuyBussinessLogic: AnyObject {
    func showCity()
}

protocol DescriptionCountryToBuyDataStore: AnyObject {
    var currentCountry: String { get set }
    var currentWeather: CurrentWeatherSevenDays { get set }
}

class DescriptionCountryToBuyInteractor: DescriptionCountryToBuyBussinessLogic, DescriptionCountryToBuyDataStore {
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
    var currentCountry: String = ""
    var presenter: DescriptionCountryToBuyPresentationLogic?
    
    func showCity() {
        //        Здесь создаем модель для текукщего города - заполняем модель все информацией -
        //        погодой,
        //        главными картинкам,
        //        описанием
        //        ссылками кнопок
        //        местами
        //        другими городами
        //        по этой модели будем заполнять экран а не как сейчас
        
        let viewModel = DescriptionCountryToBuyViewModel.CurrentCountry.ViewModel(city: currentCountry, weather: currentWeather)
        //MARK: - TODO из БД по городу берем его коорлддинаты
        let lat: CLLocationDegrees = 59.9422
        let lon: CLLocationDegrees = 30.3945
        updateWeather(latitude: lat, longitude: lon)
        presenter?.presentCountry(response: viewModel)
    }
    func updateWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        WeatherAPI().descriptionCurrentWeatherForSevenDays(latitude: latitude, longitude: longitude) { [weak self] weatherSevernDays in
            guard let self = self else { return }
            self.currentWeather = weatherSevernDays
        }
    }
}
