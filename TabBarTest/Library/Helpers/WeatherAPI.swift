//
//  WeatherAPI.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 07.10.2021.
//

import Foundation
import UIKit
import CoreLocation

class WeatherAPI {
    
    private let unit = "°"
    
    func loadCurrentWeather(latitude myCurrentLatitude: CLLocationDegrees,
                            longitude myCurrentLongitude: CLLocationDegrees,
                            completion: @escaping(String, UIImage?)->Void) {
        let url = "\(Constants.BASEURL)lat=\(myCurrentLatitude)&lon=\(myCurrentLongitude)&appid=\(Constants.APIKEY)&units=metric"
        guard let wheatherUrl = URL(string: url) else { return }

        UserDefaults.standard.set(myCurrentLatitude, forKey: UserDefaults.currentLatitude)
        UserDefaults.standard.set(myCurrentLongitude, forKey: UserDefaults.currentLongitude)
        
        URLSession.shared.dataTask(with: wheatherUrl) { [weak self] (data, response, error) in
            guard let self = self else { return }
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
                print(error)
            }
        }.resume()
    }
    
    func descriptionCurrentWeather(latitude myCurrentLatitude: CLLocationDegrees,
                            longitude myCurrentLongitude: CLLocationDegrees,
                            completion: @escaping(String, String, UIImage?, String, String, String)->Void) {
        let url = "\(Constants.BASEURL)lat=\(myCurrentLatitude)&lon=\(myCurrentLongitude)&appid=\(Constants.APIKEY)&units=metric"
        guard let wheatherUrl = URL(string: url) else { return }

        UserDefaults.standard.set(myCurrentLatitude, forKey: UserDefaults.currentLatitude)
        UserDefaults.standard.set(myCurrentLongitude, forKey: UserDefaults.currentLongitude)
        
        URLSession.shared.dataTask(with: wheatherUrl) { [weak self] (data, response, error) in
            guard let self = self else { return }
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
