//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

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
        /// "Досуг"
        static let relax = "Досуг"
        /// "Рынок"
        static let market = "Рынок"
        /// "Пляж"
        static let beach = "Пляж"
        /// "Богослужение"
        static let worship = "Богослужение"
        /// "Маршрут"
        static let travelGuide = "Маршрут"
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
    
}
