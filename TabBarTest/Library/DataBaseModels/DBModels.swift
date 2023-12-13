//
//  DBModels.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.10.2023.
//

import UIKit


// MARK: - Запрашиваем все достопримечательности по конкретному городу и стране
// sight
struct SightResponse: Codable {
    var id: Int
    var name: String
    var country: String
    var city: String
    var type: TypeSight
    var category: CategoryTypeSight
    var rating: String
    var price: Int?
    var latitude: Double
    var longitude: Double
    var address: String
    var main_phone: String?
    var additional_phone: String?
    var test: Bool
    var site: String?
    var vk: String?
    var facebook: String?
    var instagram: String?
    var youtube: String?
    var workmode: Workmode?
    var big_image: String
    var small_image: String
    var images: Dictionary<String, [ImagesArray]>?
}

struct Sight: Codable {
    var id: Int
    var name: String
    var country: String
    var city: String
    var type: TypeSight
    var category: CategoryTypeSight
    var rating: String
    var price: Int?
    var latitude: Double
    var longitude: Double
    var address: String
    var main_phone: String?
    var additional_phone: String?
    var test: Bool
    var site: String?
    var vk: String?
    var facebook: String?
    var instagram: String?
    var youtube: String?
    var workmode: Workmode?
    var big_image: String
    var small_image: String
    var images: [String]
    var favorite: String
}

// MARK: - Запрос описания тестовых данных всех стран
// cityCountryInfo
struct CountryCityInfo: Codable {
    var id: Int
    var name: String
    var price: Int
    var sight_count: Int
    var country: Country
}

// MARK: - Запрос описания города + другие города по данной стране и Запрос описания города по стране (без отправки города)
// cityAll
struct SightDescriptionResponse: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Int
    var sight_count: Int
    var latitude: Double
    var longitude: Double
    var images: Dictionary<String, [ImagesArray]>?
}

struct SightDescriptionResponce: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Int
    var sight_count: Int
    var latitude: Double
    var longitude: Double
    var images: [String]
}

//struct SightDescription {
//    var id: Int
//    var name: String
//    var description: String
//    var price: Int
//    var sight_count: Int
//    var latitude: Double
//    var longitude: Double
//    var images: [UIImage]
//}

// MARK: - Запрос на интересные события
// events
struct EventsResponce: Codable {
    var id: Int
    var name: String
    var description: String
    var country: String
    var images: Dictionary<String, [ImagesArray]>?
    var city: String
    var date: String
}

struct Events: Codable {
    var id: Int
    var name: String
    var description: String
    var country: String
    var images: [String]
    var city: String
    var date: String
}

// MARK: - Запрос на вопросы и ответ
// faq
struct FAQCity: Codable {
    var id: Int
    var question: String
    var answer: String
    var city: City
}

struct City: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Int
    var sight_count: Int
    var latitude: Double
    var longitude: Double
    var images: Dictionary<String, [ImagesArray]>?
}



// тип достопримечательности
enum TypeSight: String, Codable {
    /// Достопримечательность
    case sightSeen = "Достопримечательность"
    /// Музей
    case museum = "Музей"
    /// Культурный объект
    case cultureObject = "Культурный объект"
    /// Богослужение
    case god = "Богослужение"
    /// Избранное
    case favorite = "Избранное"
}

// категория достопримечательности
enum CategoryTypeSight: String, Codable {
    /// В окрестностях
    case farSight = "В окрестностях"
    /// Обязательно к просмотру
    case mustSee = "Обязательно к просмотру"
    /// Выбор редакции
    case selection = "Выбор редакции"
    /// Интересное
    case interesting = "Интересное"
    /// Самое посещаемое
    case mostViewed = "Самое посещаемое"
}

// режим работы достопримечательности
struct Workmode: Codable {
    var id: Int
    var date: String
    var mode: String
}

// Страна
struct Country: Codable {
    var id: Int
    var name: String
    var price: Int
    var description: String
    var sight_count: Int
    var city_count: Int
    var available: Bool
    var images: Dictionary<String, [ImagesArray]>?
}

// массив картинок
struct ImagesArray: Codable {
    var title: String
    var photo: String
}



