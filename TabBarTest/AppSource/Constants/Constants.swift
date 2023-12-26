//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

enum Constants {
    // MARK: - Google Map
    static let apiKey = "AIzaSyCT5aMIZxW2i19oK2D3VTekdAnxATzUCFU"
    static let mapStyleJSON = """
      [
        {
          "featureType" : "poi",
          "elementType" : "all",
          "stylers" : [
            {
              "visibility" : "off"
            }
          ]
        },
        {
          "featureType" : "transit",
          "elementType" : "all",
          "stylers" : [
            {
              "visibility" : "off"
            }
          ]
        }
      ]
      """
    
    // MARK: - Weather Map
    static let APIKEY = "8a8dd7602db62946ca2c5ab51405a786"
    static let BaseURLCurrentDay = "https://api.openweathermap.org/data/2.5/weather?"
    static let BaseURLSevenDays = "https://api.openweathermap.org/data/2.5/onecall?"
    static let weatherIconUrl = "https://openweathermap.org/img/wn/"
    static let weatherIconUrlEnd = "@2x.png"
    /// Ссылка на прилу в магазине
    static let shareLink = "https://apps.apple.com/ru/app/apple-store/id6446242555?mt=8"
    /// Ссылка на гуг форму для связи с поддержкой
    static var support = "https://forms.gle/qBraaNAt4nUAEBcL7"
    
    /// "°"
    static let unitCelcium = "°"
    
    // MARK: - Map Screen
    
    // MARK: - Favourites screen
    
    enum Favourites {
        /// "Избранное"
        static let titleScreen = "Избранное"
    }
    
    // MARK: - Country Screen
    
    enum County {
        
    }
    
    // MARK: - City Screen
    
    // MARK: - Cells
    enum Cells {
        /// "На карту"
        static let toMap = "На карту"
        /// "Мест"
        static let countSights = "Мест"
        /// "Отзывов"
        static let reviews = "Отзывов"
        /// "Обязательно к просмотру"
        static let mustSeeSights = "Обязательно к просмотру"
        /// "Описание города"
        static let cityDescription = "Описание города"
        /// "Читать дальше"
        static let readMore = "Читать дальше"
        /// "Скрыть"
        static let hideDescription = "Скрыть"
        /// "Избранное"
        static let favourites = "Избранное"
        /// "Интересные места"
        static let intrestingViews = "Интересные места"
        /// "Билеты на экскурсии"
        static let ticketToSights = "Билеты на экскурсии"
        /// "Вопросы и ответы"
        static let FAQ = "Вопросы и ответы"
        /// "Такси и аренда авто"
        static let rentAuto = "Такси и аренда авто"
        /// "Карты"
        static let chat = "Карты"
        /// "Погода"
        static let weather = "Погода"
        /// "Сегодня:"
        static let today = "Сегодня:"
        /// "Ощущается как "
        static let weatherFellsLike = "Ощущается как "
        /// "Восход солнца:"
        static let sunrise = "Восход солнца:"
        /// "Закат солнца:"
        static let sunset = "Закат солнца:"
        /// "Погода в "
        static let weatherInCity = "Погода в "
        /// "Места в окресностях"
        static let sightNearMe = "Места в окресностях"
        /// "См. все"
        static let lookAll = "См. все"
        /// "Выбор редакции"
        static let chooseOfRedaction = "Выбор редакции"
        /// "Музеи"
        static let museums = "Музеи"
        /// "Парки"
        static let parks = "Парки"
        /// "Самое посещаемое"
        static let mostViewed = "Самое посещаемое"
        
        
    }
    
    // MARK: - Views
    enum Views {
        /// "Поиск"
        static let search = "Поиск"
        /// "Достопримечательность"
        static let sights = "Достопримечательность"
        /// "Транспорт"
        static let transport = "Транспорт"
        /// "Культурный объект"
        static let cultureObject = "Культурный объект"
        /// "Музей"
        static let museum = "Музей"
        /// "Пляж"
        static let beach = "Пляж"
        /// "Богослужение"
        static let worship = "Богослужение"
        /// "Маршрут"
        static let travelGuide = "Маршрут"
        /// "Избранное"
        static let features = "Избранное"
        /// "В избранное"
        static let toFeatures = "В избранное"
        /// "Позвонить"
        static let makeCall = "Позвонить"
        /// "Поделиться"
        static let share = "Поделиться"
        /// "Сайт"
        static let toSite = "Сайт"
        /// "Избранное"
        static let favourite = "Избранное"
        /// "Интересные события"
        static let interesting = "Интересные события"
        /// "Вопросы и ответы"
        static let faq = "Вопросы и ответы"
        /// "Посмотреть"
        static let look = "Посмотреть"
    }
    
    enum Errors {
        /// "Location Error"
        static let locationError = "Location Error"
        /// "OK"
        static let ok = "OK"
        /// "Ошибка интернета"
        static let internetError = "Ошибка интернета"
        /// "Включите интернет"
        static let turnOnInternet = "Включите интернет"
        /// "Настройки"
        static let settings = "Настройки"
        /// "Закрыть"
        static let close = "Закрыть"
        /// "Please Allow the Location Permision to get weather of your city"
        static let allowLocationPermision = "Please Allow the Location Permision to get weather of your city"
        /// "Please Turn ON the location services on your device"
        static let allowLocationOnDevice = "Please Turn ON the location services on your device"
    }
    
    // Модель Билетов на экскурсии
    static let guidesArray: [CityGuideSightsModel] = [
        CityGuideSightsModel(city: "Санкт-Петербург", cityUrl: "https://experience.tripster.ru/experience/Saint_Petersburg/", guides: [
            GuideSightsModel(image: UIImage(named: "SPBGuides-1") ?? UIImage(), name: "Петербург: путешествие, исполняющее мечты!", price: 6950, rating: 4.99, reviews: 152, guideUrl: "https://experience.tripster.ru/experience/27391/"),
            GuideSightsModel(image: UIImage(named: "SPBGuides-2") ?? UIImage(), name: "Стрит-арт и дворы Петербурга: авторская прогулка", price: 3900, rating: 4.98, reviews: 127, guideUrl: "https://experience.tripster.ru/experience/31689/"),
            GuideSightsModel(image: UIImage(named: "SPBGuides-3") ?? UIImage(), name: "Путешествие по проходным дворам Санкт-Петербурга", price: 1100, rating: 4.97, reviews: 160, guideUrl: "https://experience.tripster.ru/experience/14588/"),
            GuideSightsModel(image: UIImage(named: "SPBGuides-4") ?? UIImage(), name: "Истории и легенды аптеки доктора Пеля", price: 2600, rating: 4.96, reviews: 207, guideUrl: "https://experience.tripster.ru/experience/13705/"),
            GuideSightsModel(image: UIImage(named: "SPBGuides-5") ?? UIImage(), name: "Обзорная по Петербургу + Петропавловская крепость", price: 900, rating: 4.68, reviews: 205, guideUrl: "https://experience.tripster.ru/experience/41860/")]),
        
        CityGuideSightsModel(city: "Москва", cityUrl: "https://experience.tripster.ru/experience/Moscow/", guides: [
            GuideSightsModel(image: UIImage(named: "MSKGuides-1") ?? UIImage(), name: "Москва-Сити: смотровая площадка PANORAMA360", price: 2290, rating: 4.54, reviews: 13, guideUrl: "https://experience.tripster.ru/experience/37836/"),
            GuideSightsModel(image: UIImage(named: "MSKGuides-2") ?? UIImage(), name: "Москва-Сити: небоскребы и современное искусство", price: 650, rating: 4.97, reviews: 466, guideUrl: "https://experience.tripster.ru/experience/26588/"),
            GuideSightsModel(image: UIImage(named: "MSKGuides-3") ?? UIImage(), name: "Влюбиться в Москву за один день!", price: 9500, rating: 5.0, reviews: 194, guideUrl: "https://experience.tripster.ru/experience/24451/"),
            GuideSightsModel(image: UIImage(named: "MSKGuides-4") ?? UIImage(), name: "Москва глазами реставратора (групповая экскурсия)", price: 1500, rating: 5.0, reviews: 9, guideUrl: "https://experience.tripster.ru/experience/52670/"),
            GuideSightsModel(image: UIImage(named: "MSKGuides-5") ?? UIImage(), name: "Кузнецкий Мост, 1902. Красиво жить не запретишь!", price: 1700, rating: 5.0, reviews: 5, guideUrl: "https://experience.tripster.ru/experience/51873/")]),
        
        CityGuideSightsModel(city: "Казань", cityUrl: "https://experience.tripster.ru/experience/Kazan/", guides: [
            GuideSightsModel(image: UIImage(named: "KAZGuides-1") ?? UIImage(), name: "Большое знакомство с Казанью", price: 1200, rating: 4.66, reviews: 522, guideUrl: "https://experience.tripster.ru/experience/19437/"),
            GuideSightsModel(image: UIImage(named: "KAZGuides-2") ?? UIImage(), name: "Ночная Казань и катание на колесе обозрения «Вокруг света»", price: 1400, rating: 4.73, reviews: 537, guideUrl: "https://experience.tripster.ru/experience/34841/"),
            GuideSightsModel(image: UIImage(named: "KAZGuides-3") ?? UIImage(), name: "Вся Казань и чаепитие с татарскими сладостями", price: 1700, rating: 4.81, reviews: 631, guideUrl: "https://experience.tripster.ru/experience/27586/"),
            GuideSightsModel(image: UIImage(named: "KAZGuides-4") ?? UIImage(), name: "Казань — первое свидание", price: 6200, rating: 4.93, reviews: 307, guideUrl: "https://experience.tripster.ru/experience/26787/"),
            GuideSightsModel(image: UIImage(named: "KAZGuides-5") ?? UIImage(), name: "Колоритная и секретная Казань: прогулка с фотографом", price: 3900, rating: 4.97, reviews: 186, guideUrl: "https://experience.tripster.ru/experience/40810/")]),
        
        CityGuideSightsModel(city: "Нижний Новгород", cityUrl: "https://experience.tripster.ru/experience/Nizhny_Novgorod/", guides: [
            GuideSightsModel(image: UIImage(named: "NOVGuides-1") ?? UIImage(), name: "Нижний Новгород — «город грехов»", price: 5800, rating: 4.96, reviews: 118, guideUrl: "https://experience.tripster.ru/experience/28371/"),
            GuideSightsModel(image: UIImage(named: "NOVGuides-2") ?? UIImage(), name: "Сердце Нижнего: групповая экскурсия в кремль и его окрестности", price: 1875, rating: 4.99, reviews: 280, guideUrl: "https://experience.tripster.ru/experience/43532/"),
            GuideSightsModel(image: UIImage(named: "NOVGuides-3") ?? UIImage(), name: "Театрализованный квест от Нижегородской ярмарки до Стрелки", price: 1900, rating: 4.88, reviews: 33, guideUrl: "https://experience.tripster.ru/experience/34328/"),
            GuideSightsModel(image: UIImage(named: "NOVGuides-4") ?? UIImage(), name: "Здравствуй, Нижний Новгород!", price: 3900, rating: 4.94, reviews: 244, guideUrl: "https://experience.tripster.ru/experience/23795/"),
            GuideSightsModel(image: UIImage(named: "NOVGuides-5") ?? UIImage(), name: "Мистика и история Нижнего Новгорода", price: 2500, rating: 4.89, reviews: 679, guideUrl: "https://experience.tripster.ru/experience/6516/")]),
        
        CityGuideSightsModel(city: "Екатеринбург", cityUrl: "https://experience.tripster.ru/experience/Yekaterinburg/", guides: [
            GuideSightsModel(image: UIImage(named: "EKBGuides-1") ?? UIImage(), name: "Три моста истории", price: 1000, rating: 4.99, reviews: 87, guideUrl: "https://experience.tripster.ru/experience/24387/"),
            GuideSightsModel(image: UIImage(named: "EKBGuides-2") ?? UIImage(), name: "Два в одном: Ганина Яма и граница «Европа-Азия»", price: 9990, rating: 5.0, reviews: 90, guideUrl: "https://experience.tripster.ru/experience/25659/"),
            GuideSightsModel(image: UIImage(named: "EKBGuides-3") ?? UIImage(), name: "Екатеринбург — столица конструктивизма", price: 4000, rating: 4.99, reviews: 102, guideUrl: "https://experience.tripster.ru/experience/13324/"),
            GuideSightsModel(image: UIImage(named: "EKBGuides-4") ?? UIImage(), name: "С Екатеринбургом на «ты»", price: 3000, rating: 5.0, reviews: 78, guideUrl: "https://experience.tripster.ru/experience/11368/"),
            GuideSightsModel(image: UIImage(named: "EKBGuides-5") ?? UIImage(), name: "Екатеринбург: самое интересное", price: 7990, rating: 4.98, reviews: 97, guideUrl: "https://experience.tripster.ru/experience/25609/")]),
        
        CityGuideSightsModel(city: "Новосибирск", cityUrl: "https://experience.tripster.ru/experience/Novosibirsk/", guides: [
            GuideSightsModel(image: UIImage(named: "NVSGuides-1") ?? UIImage(), name: "«Кругосветка» по новосибирским наукоградам", price: 8060, rating: 4.96, reviews: 27, guideUrl: "https://experience.tripster.ru/experience/9853/"),
            GuideSightsModel(image: UIImage(named: "NVSGuides-2") ?? UIImage(), name: "Атмосферный Новосибирск", price: 3250, rating: 4.97, reviews: 32, guideUrl: "https://experience.tripster.ru/experience/39801/"),
            GuideSightsModel(image: UIImage(named: "NVSGuides-3") ?? UIImage(), name: "Красный проспект — сердце Новосибирска", price: 5500, rating: 4.95, reviews: 140, guideUrl: "https://experience.tripster.ru/experience/26777/"),
            GuideSightsModel(image: UIImage(named: "NVSGuides-4") ?? UIImage(), name: "Автомобильная экскурсия по вечерней столице Сибири", price: 5200, rating: 4.83, reviews: 66, guideUrl: "https://experience.tripster.ru/experience/9851/"),
            GuideSightsModel(image: UIImage(named: "NVSGuides-5") ?? UIImage(), name: "Три возраста Новосибирска — позавчера, вчера, сегодня", price: 4800, rating: 4.98, reviews: 47, guideUrl: "https://experience.tripster.ru/experience/25365/")])
    ]
}
