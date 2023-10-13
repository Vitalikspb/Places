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
    
    // MARK: - Сохранение Моделей
    
    /// Сохранение events
    func saveEvents(value: [Events?], data: Data) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "events")
        UserDefaults.standard.set(data.count, forKey: "eventsData")
    }
    
    /// Сохранение FAQCity
    func saveFAQCity(value: [FAQCity?], data: Data) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "FAQCity")
        UserDefaults.standard.set(data.count, forKey: "FAQCityData")
    }
    
    // MARK: - Получение Моделей
    
    func getEvents() -> [Events] {
        if let data = UserDefaults.standard.value(forKey:"events") as? Data {
            let cellUnwrapped = try? PropertyListDecoder().decode(Array<Events>.self,
                                                                  from: data)
            return cellUnwrapped ?? []
        }
        return []
    }
    
    func getFAQCity() -> [FAQCity] {
        if let data = UserDefaults.standard.value(forKey:"FAQCity") as? Data {
            let cellUnwrapped = try? PropertyListDecoder().decode(Array<FAQCity>.self,
                                                                  from: data)
            return cellUnwrapped ?? []
        }
        return []
    }
}
