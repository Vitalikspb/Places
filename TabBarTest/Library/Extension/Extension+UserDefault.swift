//
//  Extension+UserDefault.swift
//  TabBarTest
//
//

import Foundation

extension UserDefaults {
    
    // текущее местоположение для вкладки Страна
    static var currentLocation: String { "currentLocation" }
    
    // текущий город для экрана дом инфа по городу
    static var currentCity: String { "currentCity" }
    
    // текущее местоположение
    static var currentLongitude: String { "currentLongitude" }
    static var currentLatitude: String { "currentLatitude" }
    
    // для отображения города на карте из экрана Страна
    static var showSelectedCity: String { "showSelectedCity" }
    static var showSelectedCityWithLongitude: String { "showSelectedCityWithLongitude" }
    static var showSelectedCityWithLatitude: String { "showSelectedCityWithLatitude" }
    
    // для отображения Места на карте из экрана Страна
    static var showSelectedSight: String { "showSelectedSight" }
    static var showSelectedSightName: String { "showSelectedSightName" }
}
