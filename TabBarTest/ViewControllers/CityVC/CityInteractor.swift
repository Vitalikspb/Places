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
    func openTicketSite()
    func updateFavorites(withName name: String)
}

protocol CityDataStore: AnyObject {
    var currentCity: String { get set }
    var currentCountry: String { get set }
    var currentWeather: CurrentWeatherSevenDays { get set }
    var cityInfo: CityViewModel.AllCountriesInTheWorld.ViewModel { get set }
    var sights: [Sight] { get set }
}

class CityInteractor: CityBussinessLogic, CityDataStore {
    var sights: [Sight] = []
    
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
        
        updateWeather(latitude: lat, longitude: lon)
        loadSights(currentCity: currentCity)
        presenter?.presentCity(response: viewModelWeather, viewModelCityData: cityInfo, viewModelSightData: sights)
    }
    
    // Открываем сайт с дилетами для текущего города
    func openTicketSite() {
        print("открыть сайт с билетами для города \(currentCity)")
    }
    
    // Обновляем список избранного
    func updateFavorites(withName nameFavorites: String) {
        ManagesFavorites.updateFavorites(sights: &sights, withName: nameFavorites)
    }
    
    // Загружаем погоду
    private func updateWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        WeatherAPI().descriptionCurrentWeatherForSevenDays(latitude: latitude, longitude: longitude) { [weak self] weatherSevernDays in
            guard let self = self else { return }
            self.currentWeather = weatherSevernDays
            self.currentWeather.sevenDaysWeather.removeFirst()
        }
    }
    
    // Сохраняем достопримечательности для конкретного города
    private func loadSights(currentCity: String) {
        let allSights = UserDefaults.standard.getSight()
        var tempSight = [Sight]()
        var tempSightWithFavorites = [Sight]()
        // Из всех достопримечательностей оставлям только для текущего города
        for (_,val) in allSights.enumerated() {
            if val.city == currentCity {
                tempSight.append(val)
            }
        }
        
        let favorites = UserDefaults.standard.getFavorites()
        // Из избранного достопримечательностей сравниваем со списком достопримечательностей есть ли они в списке и перезаписываем список достопримечательностей
        var valAllSightTemp = tempSight
        
        for (ind,_) in tempSight.enumerated() {
            valAllSightTemp[ind].favorite = "AddtofavoritesUnselected"
        }
        
        for (ind,valAllSight) in tempSight.enumerated() {
            for (_,valFavorite) in favorites.enumerated() {
                if valFavorite.name == valAllSight.name {
                    valAllSightTemp[ind].favorite =  "AddtofavoritesSelected"
                }
            }
        }
        tempSightWithFavorites = valAllSightTemp
        
        if favorites.isEmpty {
            tempSightWithFavorites = tempSight
        }
        self.sights = tempSightWithFavorites
    }
}

