//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import Foundation

    
    // для карты текущая погода по месторасположению
    struct CurrentWeather: Decodable {
        let coord: CoordinatesWeather
        let weather: [WeatherWeather]
        let base: String
        let main: MainWeather
        let visibility: Int
        let wind: WindWeather
        let clouds: cloudsWeather
        let dt: Int
        let sys: sysWeather
        let timezone: Int
        let id: Int
        let name: String
        let cod: Int
    }
    struct CoordinatesWeather: Decodable {
        let lon: Double
        let lat: Double
    }
    struct WeatherWeather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    struct MainWeather: Decodable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Double
        let humidity: Double
    }
    struct WindWeather: Decodable {
        let speed: Double
        let deg: Int
    }
    struct cloudsWeather: Decodable {
        let all: Int
    }
    struct sysWeather: Decodable {
        let type: Int
        let id: Int
        let message: Double?
        let country: String
        let sunrise: Int
        let sunset: Int
    }
 
