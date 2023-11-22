//
//  CurrentCityInteractor.swift
//  TabBarTest
//
//

import UIKit
import CoreLocation


protocol CurrentCityBussinessLogic: AnyObject {
    func showCity(named: String)
    func openTicketSite()
    func updateFavorites(withName name: String)
}

protocol CurrentCityDataStore: AnyObject {
    var currentCity: String { get set }
    var currentCountry: String { get set }
    var currentWeather: CurrentWeatherSevenDays { get set }
    var cityInfo: CurrentCityViewModel.AllCountriesInTheWorld.ViewModel { get set }
    var sights: [Sight] { get set }
}

class CurrentCityInteractor: CurrentCityBussinessLogic, CurrentCityDataStore {
    var sights: [Sight] = []
    
    var cityInfo: CurrentCityViewModel.AllCountriesInTheWorld.ViewModel = CurrentCityViewModel.AllCountriesInTheWorld.ViewModel(
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
        sevenDaysWeather: [
            WeatherSevenDays(dayOfWeek: 0,
                             tempFrom: 0.0,
                             tempTo: 0.0,
                             image: UIImage(),
                             description: "")]) {
                                 didSet {
                                     let viewModel = CurrentCityViewModel.CurrentCity.ViewModel(
                                        city: currentCity,
                                        weather: currentWeather)
                                     presenter?.updateWeather(response: viewModel)
                                 }
                             }
    var currentCity: String = ""
    var currentCountry: String = ""
    var presenter: CurrentCityPresenterLogic?
    
    func showCity(named: String) {
        var cities = UserDefaults.standard.getSightDescription()
        var otherCityData = [SightDescription]()
        var country: SightDescription?
        let viewModelWeather = CurrentCityViewModel.CurrentCity.ViewModel(city: currentCity, weather: currentWeather)

        // оставляем только текущий город
        cities.forEach {
            if $0.name == named {
                country = $0
            }
        }
        // Удаляем текущий город для "других городов"
        for (_,val) in cities.enumerated() {
            if val.name != named {
                otherCityData.append(val)
            }
        }
        guard let country = country else { return }
        let titleSecData = TitleSection(country: "Россия",
                                        subTitle: "",
                                        latitude: 0.0,
                                        longitude: 0.0,
                                        available: true,
                                        iconName: "")
        let curCityModelData = SightDescription(id: country.id,
                                                name: country.name,
                                                description: country.description,
                                                price: country.price,
                                                sight_count: country.sight_count,
                                                latitude: country.latitude,
                                                longitude: country.longitude,
                                                images: country.images)
        
        cityInfo = CurrentCityViewModel.AllCountriesInTheWorld.ViewModel(titlesec: titleSecData,
                                                                         model: [curCityModelData])
        updateWeather(latitude: country.latitude,
                      longitude: country.longitude)
        loadSights(currentCity: named)
        presenter?.presentCity(response: viewModelWeather, 
                               viewModelCityData: cityInfo,
                               viewModelSightData: sights, 
                               otherCityData: otherCityData)
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

