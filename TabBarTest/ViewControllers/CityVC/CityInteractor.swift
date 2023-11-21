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
//        print("showCity sights:\(sights)")
        presenter?.presentCity(response: viewModelWeather, viewModelCityData: cityInfo, viewModelSightData: sights)
    }
    
    // Открываем сайт с дилетами для текущего города
    func openTicketSite() {
        print("открыть сайт с билетами для города \(currentCity)")
    }
    
    // Обновляем список избранного
    func updateFavorites(withName nameFavorites: String) {
        
        var newFavorites = true
        var curIndexOfFavorite = -1
        var favorites = UserDefaults.standard.getFavorites()
        
        for (ind,val) in favorites.enumerated() {
            if val.name == nameFavorites {
                newFavorites = false
                curIndexOfFavorite = ind
            }
        }
        
        
        if newFavorites {
            // если нету в списке избранного, добавляем в список избранного
            if let item = sights.filter({ $0.name == nameFavorites }).last {
                favorites.append(item)
            }
        } else {
            // если уже есть в списке избранного, удаляем из списока избранного
            favorites.remove(at: curIndexOfFavorite)
        }
        print("saveFavorites favorites:\(favorites)")
        UserDefaults.standard.saveFavorites(value: favorites)
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
//        print("loadSights favorites:\(favorites)")
        // Из избранного достопримечательностей сравниваем со списком достопримечательностей есть ли они в списке и перезаписываем список достопримечательностей
        
        for (_,valFavorite) in favorites.enumerated() {
            for (_,valAllSight) in tempSight.enumerated() {
                var valAllSightTemp = valAllSight
                print("\(valFavorite.name) == \(valAllSight.name)")
                if valFavorite.name == valAllSight.name {
                    valAllSightTemp.favorite = true
                } else {
                    valAllSightTemp.favorite = false
                }
                tempSightWithFavorites.append(valAllSightTemp)
            }
        }
        
        if favorites.isEmpty {
            tempSightWithFavorites = tempSight
        }
//        print("tempSightWithFavorites:\(tempSightWithFavorites)")
        self.sights = tempSightWithFavorites
    }
}

