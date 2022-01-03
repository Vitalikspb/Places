//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import Foundation
import UIKit

// структура для погоды на текущий день и на 7 дней
struct CurrentWeatherSevenDays {
    var currentWeather: CurrentWeatherOfSevenDays
    var sevenDaysWeather: [WeatherSevenDays]
}
// структура для погоды на текущий день
struct CurrentWeatherOfSevenDays {
    var todayTemp: Double
    var imageWeather: UIImage
    var description: String
    var feelsLike: Double
    var sunrise: Int
    var sunset: Int
}
// структура для погоды на 7 дней
struct WeatherSevenDays {
    var dayOfWeek: Int
    var tempFrom: Double
    var tempTo: Double
    var image: UIImage
    var description: String
}


// для карты текущая погода на 7 дней по месторасположению
struct CurrentWeatherForSevenDays: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: CurrentWeatherDescriptionOfFirstDay
    let daily: [WeatherSevenDayOfSeven]
}

struct CurrentWeatherDescriptionOfFirstDay: Decodable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Double
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let weather: [WeatherWeather]
}

struct TempDescriptions: Decodable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct FeelsLikeDescriptions: Decodable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct WeatherSevenDayOfSeven: Decodable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moon_phase: Double
    let temp: TempDescriptions
    let feels_like: FeelsLikeDescriptions
    let pressure: Double
    let humidity: Double
    let dew_point: Double
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double
    let weather: [WeatherWeather]
    let clouds: Int
    let pop: Double
    let snow: Double?
    let uvi: Double
}

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

