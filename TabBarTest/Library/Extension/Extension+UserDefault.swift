//
//  Extension+UserDefault.swift
//  TabBarTest
//
//

import Foundation

extension UserDefaults {
    
    // MARK: - Properties
    
    // текущий язык приложения
    static var currentLang: String { "currentLang" }
    
    // текущее местоположение для вкладки Страна
    static var currentLocation: String { "currentLocation" }
    
    // текущий город для экрана дом инфа по городу
    static var currentCity: String { "currentCity" }
    
    // Первый раз запускаем прилу
    static var firstOpenApp: String { "firstOpenApp" }
    
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
    
    // для отображения Страны на карте из экрана Страна
    static var showSelectedCountry: String { "showSelectedCountry" }
    
    // MARK: - Сохранение Моделей
    
    /// Сохранение Sight
    func saveSight(value: [Sight?], data: Data) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "Sight")
    }
    
    /// Сохранение saveAllCity
    func saveAllCity(value: [SightDescriptionResponce?], data: Data) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "SightDescriptionResponce")
    }
    
    /// Сохранение saveAllCity
    func saveCityCountryInfo(value: [CountryCityInfo?], data: Data) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "CountryCityInfo")
    }
    
    /// Сохранение events
    func saveEvents(value: [Events?], data: Data) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "events")
    }
    
    /// Сохранение FAQCity
    func saveFAQCity(value: [FAQCity?], data: Data) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "FAQCity")
    }
    
    /// Сохранение Избранного
    func saveFavorites(value: [Sight?]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "favorites")
    }
    
    // MARK: - Получение Моделей
    
    /// Запрос достопримечательностей
    func getSight() -> [Sight] {
        if let data = UserDefaults.standard.value(forKey: "Sight") as? Data {
            let cellUnwrapped = try? PropertyListDecoder().decode(Array<Sight>.self, from: data)
            return cellUnwrapped ?? []
        }
        return []
    }
    
    /// Запрос описании города для стране
    func getSightDescription() -> [SightDescriptionResponce] {
        if let data = UserDefaults.standard.value(forKey: "SightDescriptionResponce") as? Data {
            let cellUnwrapped = try? PropertyListDecoder().decode(Array<SightDescriptionResponce>.self, from: data)
            return cellUnwrapped ?? []
        }
        return []
    }
    
    /// Запрос города инфы
    func getCountryCityInfo() -> [CountryCityInfo] {
        if let data = UserDefaults.standard.value(forKey: "CountryCityInfo") as? Data {
            let cellUnwrapped = try? PropertyListDecoder().decode(Array<CountryCityInfo>.self, from: data)
            return cellUnwrapped ?? []
        }
        return []
    }
    
    /// Интересные события
    func getEvents() -> [Events] {
        if let data = UserDefaults.standard.value(forKey: "events") as? Data {
            let cellUnwrapped = try? PropertyListDecoder().decode(Array<Events>.self, from: data)
            return cellUnwrapped ?? []
        }
        return []
    }
    
    /// Вопросы и ответы
    func getFAQCity() -> [FAQCity] {
        if let data = UserDefaults.standard.value(forKey: "FAQCity") as? Data {
            let cellUnwrapped = try? PropertyListDecoder().decode(Array<FAQCity>.self, from: data)
            return cellUnwrapped ?? []
        }
        return []
    }
    
    /// Запрос избранного
    func getFavorites() -> [Sight] {
        if let data = UserDefaults.standard.value(forKey: "favorites") as? Data {
            let cellUnwrapped = try? PropertyListDecoder().decode(Array<Sight>.self, from: data)
            return cellUnwrapped ?? []
        }
        return []
    }
}
