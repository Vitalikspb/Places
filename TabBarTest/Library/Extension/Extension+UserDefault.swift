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
    
    /// Сохранение Sight
    func saveSight(value: [Sight?], data: Data) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "Sight")
        UserDefaults.standard.set(data.count, forKey: "SightData")
    }
    
    /// Сохранение saveAllCity
    func saveAllCity(value: [SightDescription?], data: Data) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "SightDescription")
        UserDefaults.standard.set(data.count, forKey: "SaveAllCityData")
    }
    
    /// Сохранение saveAllCity
    func saveCityCountryInfo(value: [CountryCityInfo?], data: Data) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "CountryCityInfo")
        UserDefaults.standard.set(data.count, forKey: "SaveCountryCityInfo")
    }
    
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
    
    /// Запрос достопримечательностей
    func getSight() -> [Sight] {
        if let data = UserDefaults.standard.value(forKey:"Sight") as? Data {
            let cellUnwrapped = try? PropertyListDecoder().decode(Array<Sight>.self,
                                                                  from: data)
            return cellUnwrapped ?? []
        }
        return []
    }
    
    /// Запрос описании города для стране
    func getSightDescription() -> [SightDescription] {
        if let data = UserDefaults.standard.value(forKey:"SightDescription") as? Data {
            let cellUnwrapped = try? PropertyListDecoder().decode(Array<SightDescription>.self,
                                                                  from: data)
            return cellUnwrapped ?? []
        }
        return []
    }
    
    /// Запрос города инфы
    func getCountryCityInfo() -> [CountryCityInfo] {
        if let data = UserDefaults.standard.value(forKey:"CountryCityInfo") as? Data {
            let cellUnwrapped = try? PropertyListDecoder().decode(Array<CountryCityInfo>.self,
                                                                  from: data)
            return cellUnwrapped ?? []
        }
        return []
    }
    
    /// Интересные события
    func getEvents() -> [Events] {
        if let data = UserDefaults.standard.value(forKey:"events") as? Data {
            let cellUnwrapped = try? PropertyListDecoder().decode(Array<Events>.self,
                                                                  from: data)
            return cellUnwrapped ?? []
        }
        return []
    }
    
    /// Вопросы и ответы
    func getFAQCity() -> [FAQCity] {
        if let data = UserDefaults.standard.value(forKey:"FAQCity") as? Data {
            let cellUnwrapped = try? PropertyListDecoder().decode(Array<FAQCity>.self,
                                                                  from: data)
            return cellUnwrapped ?? []
        }
        return []
    }
}
