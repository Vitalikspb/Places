//
//  WeatherAPI.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 07.10.2021.
//

import Foundation
import UIKit
import CoreLocation
import SwiftUI

struct CurrentWeatherSevenDays {
    var currentWeather: CurrentWeatherOfSevenDays
    var sevenDaysWeather: [WeatherSevenDays]
}

struct CurrentWeatherOfSevenDays {
    var todayTemp: Double
    var imageWeather: UIImage
    var description: String
    var feelsLike: Double
    var sunrise: Int
    var sunset: Int
}

struct WeatherSevenDays {
    var dayOfWeek: Int
    var tempFrom: Double
    var tempTo: Double
    var image: UIImage
    var description: String
}

class WeatherAPI {
    
    private let unit = "°"
    // Запрос текущей погоды для экрана карты
    func loadCurrentWeather(latitude myCurrentLatitude: CLLocationDegrees,
                            longitude myCurrentLongitude: CLLocationDegrees,
                            completion: @escaping(String, UIImage?)->Void) {
        let url = "\(Constants.BaseURLCurrentDay)lat=\(myCurrentLatitude)&lon=\(myCurrentLongitude)&appid=\(Constants.APIKEY)&units=metric"
        guard let wheatherUrl = URL(string: url) else { return }
        
        UserDefaults.standard.set(myCurrentLatitude, forKey: UserDefaults.currentLatitude)
        UserDefaults.standard.set(myCurrentLongitude, forKey: UserDefaults.currentLongitude)
        
        URLSession.shared.dataTask(with: wheatherUrl) {  (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetch request of weather")
                return
            }
            do {
                let forecast = try JSONDecoder().decode(CurrentWeather.self, from: data)
                completion("\(Int(forecast.main.temp))\(self.unit)",
                           self.loadIconFromApi(with: forecast.weather[0].icon))
            } catch let error {
                print("error weather location: \(error)")
            }
        }.resume()
    }
    
    // Запрос текущей погоды для текущего города
    func descriptionCurrentWeather(latitude myCurrentLatitude: CLLocationDegrees,
                                   longitude myCurrentLongitude: CLLocationDegrees,
                                   completion: @escaping(String, String, UIImage?, String, String, String)->Void) {
        let curLang = "&lang=\(UserDefaults.standard.string(forKey: UserDefaults.currentLang) ?? "")"
        let url = "\(Constants.BaseURLCurrentDay)lat=\(myCurrentLatitude)&lon=\(myCurrentLongitude)&appid=\(Constants.APIKEY)&units=metric\(curLang)"
        guard let wheatherUrl = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: wheatherUrl) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetch request of weather")
                return
            }
            do {
                let forecast = try JSONDecoder().decode(CurrentWeather.self, from: data)
                completion("\(Int(forecast.main.temp))\(self.unit)",
                           "\(Int(forecast.main.feels_like))\(self.unit)",
                           self.loadIconFromApi(with: forecast.weather[0].icon),
                           "\(forecast.weather[0].description)",
                           "\(forecast.sys.sunrise)",
                           "\(forecast.sys.sunset)")
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    // Запрос текущей погоды для текущего города на 7 дней
    func descriptionCurrentWeatherForSevenDays(latitude myCurrentLatitude: CLLocationDegrees,
                                               longitude myCurrentLongitude: CLLocationDegrees,
                                               completion: @escaping(CurrentWeatherSevenDays)->Void) {
        let curLang = "\(UserDefaults.standard.string(forKey: UserDefaults.currentLang) ?? "")"
        let excludeOptions = "minutely,hourly,alerts"
        let metricOptions = "metric"
        let url = "\(Constants.BaseURLSevenDays)lat=\(myCurrentLatitude)&lon=\(myCurrentLongitude)&exclude=\(excludeOptions)&appid=\(Constants.APIKEY)&units=\(metricOptions)&lang=\(curLang)"
        //        https://api.openweathermap.org/data/2.5/onecall?lat=59.939634&lon=30.3104843&exclude=minutely,hourly&units=metric&appid=8a8dd7602db62946ca2c5ab51405a786&lang=ru
        
        guard let wheatherURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: wheatherURL) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetch request of weather")
                return
            }
            do {
                let forecast = try JSONDecoder().decode(CurrentWeatherForSevenDays.self, from: data)
                // возвращаем погоду с описанием на 7 дней кроме рассвета и заката, текущего дня все полостью описание
                var currentWeatherOfSevenDays: CurrentWeatherOfSevenDays!
                currentWeatherOfSevenDays = CurrentWeatherOfSevenDays(
                    todayTemp: forecast.current.temp,
                    imageWeather: self.loadIconFromApi(with: forecast.current.weather.first!.icon),
                    description: forecast.current.weather.first!.description,
                    feelsLike: forecast.current.feels_like,
                    sunrise: forecast.current.sunrise,
                    sunset: forecast.current.sunset)
                var weatherSevenDaysArray = [WeatherSevenDays]()
                forecast.daily.forEach { item in
                    weatherSevenDaysArray = [WeatherSevenDays(
                        dayOfWeek: item.dt,
                        tempFrom: item.temp.day,
                        tempTo: item.temp.night,
                        image: self.loadIconFromApi(with: item.weather.first!.icon) ,
                        description: item.weather.first!.description)]
                }
                let weatherSevenDays = CurrentWeatherSevenDays(currentWeather: currentWeatherOfSevenDays,
                                                               sevenDaysWeather: weatherSevenDaysArray)
                completion(weatherSevenDays)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    // Загрузка иконок для текущей погоды
    func loadIconFromApi(with iconCode: String?) -> UIImage {
        guard let iconCode = iconCode else {
            return UIImage(systemName: "gear")!
        }
        return UIImage(named: iconCode) ?? UIImage(systemName: "gear")!
    }
}
