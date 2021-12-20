//
//  WeatherAPI.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 07.10.2021.
//

import Foundation
import UIKit
import CoreLocation

struct CurrentWeatherSevenDays {
    var currentWeather: CurrentWeatherOfSevenDays
    var sevenDaysWeather: [WeatherSevenDays]
}

struct CurrentWeatherOfSevenDays {
    var todayTemp: Double
    var imageWeather: UIImage
    var description: String
    var feelsLike: String
    var sunrise: Int
    var sunset: Int
}

struct WeatherSevenDays {
    var dayOfWeek: String
    var tempFrom: String
    var tempTo: String
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
                self.loadIconFromApi(with: forecast.weather[0].icon) { image in
                    completion("\(Int(forecast.main.temp))\(self.unit)", image)
                }
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
                self.loadIconFromApi(with: forecast.weather[0].icon) { image in
                    completion("\(Int(forecast.main.temp))\(self.unit)",
                               "\(Int(forecast.main.feels_like))\(self.unit)",
                               image,
                               "\(forecast.weather[0].description)",
                               "\(forecast.sys.sunrise)",
                               "\(forecast.sys.sunset)")
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    // Запрос текущей погоды для текущего города на 7 дней
    func descriptionCurrentWeatherForSevenDays(latitude myCurrentLatitude: CLLocationDegrees,
                            longitude myCurrentLongitude: CLLocationDegrees,
                            completion: @escaping([WeatherSevenDays])->Void) {
        let curLang = "\(UserDefaults.standard.string(forKey: UserDefaults.currentLang) ?? "")"
        let excludeOptions = "minutely,hourly,alerts"
        let metricOptions = "metric"
        let url = "\(Constants.BaseURLSevenDays)lat=\(myCurrentLatitude)&lon=\(myCurrentLongitude)&exclude=\(excludeOptions)&appid=\(Constants.APIKEY)&units=\(metricOptions)&lang=\(curLang)"
        print(url)
        
//        https://api.openweathermap.org/data/2.5/onecall?lat=59.939634&lon=30.3104843&exclude=minutely,hourly&units=metric&appid=8a8dd7602db62946ca2c5ab51405a786&lang=ru
        
        guard let wheatherURL = URL(string: url) else { return }

        URLSession.shared.dataTask(with: wheatherURL) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetch request of weather")
                return
            }
            do {
                
                let forecast = try JSONDecoder().decode(CurrentWeatherForSevenDays.self, from: data)
                print(forecast)
                
                var weatherSevenDays: [WeatherSevenDays]!
                
//                for (ind,val) in forecast.weathers.enumerated() {
//                    self.loadIconsFromApiForSevenDays(with: val.weather[ind].icon) { image in
//                        weatherSevenDays.append(WeatherSevenDays(
//                            dayOfWeek: "thuesday",
//                            tempFrom: "-11",
//                            tempTo: "+5",
//                            image: image ?? UIImage(),
//                            description: val.weather[ind].description))
//                    }
//
//                }
                completion(weatherSevenDays)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    // Загрузка иконок для текущей погоды на 7 дней
    private func loadIconsFromApiForSevenDays(with iconCode: String?, completion: @escaping(UIImage?)->Void) {
        guard let iconCode = iconCode,
              let imageUrl = URL(string: Constants.weatherIconUrl + iconCode + Constants.weatherIconUrlEnd) else { return }
            DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: imageUrl) {
                completion(UIImage(data: data))
            }
        }
    }
    
    // Загрузка иконок для текущей погоды
    private func loadIconFromApi(with iconCode: String?, completion: @escaping(UIImage?)->Void) {
        guard let iconCode = iconCode,
              let imageUrl = URL(string: Constants.weatherIconUrl + iconCode + Constants.weatherIconUrlEnd) else { return }
            DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: imageUrl) {
                completion(UIImage(data: data))
            }
        }
    }
}
