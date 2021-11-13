//
//  Extension+UserDefault.swift
//  TabBarTest
//
//  Created by ViceCode on 20.10.2021.
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
}
