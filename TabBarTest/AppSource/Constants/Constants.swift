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
    static let BASEURL = "https://api.openweathermap.org/data/2.5/weather?"
    static let weatherIconUrl = "https://openweathermap.org/img/wn/"
    static let weatherIconUrlEnd = "@2x.png"
    
    // MARK: - Map Screen
    
    // MARK: - Favourites screen
    
    enum Favourites {
        static let titleScreen = "Сохраненное"
    }
    
    // MARK: - Country Screen
    
    enum County {
        
    }
    
    // MARK: - City Screen
    
    // MARK: - Cells
    enum Cells {
        static let toMap = "На карту"
        static let countSights = "Мест"
        static let reviews = "Отзывов"
        static let mustSeeSights = "Обязательно к просмотру"
        static let cityDescription = "Описание города"
        static let readMore = "Читать дальше"
        static let hideDescription = "Скрыть"
        static let favourites = "Избранное"
        static let intrestingViews = "Интересные события"
        static let ticketToSights = "Билеты на экскурсии"
        static let FAQ = "Вопросы и ответы"
        static let rentAuto = "Такси и аренда авто"
        static let chat = "Чат"
        static let weather = "Погода"
        static let today = "Сегодня"
        static let weatherFellsLike = "Ощущается как "
        static let sunrise = "Восход солнца"
        static let sunset = "Закат солнца"
        static let weatherInCity = "Погода в "
        static let sightNearMe = "Места в окресностях"
        static let chooseOfRedaction = "Выбор редакции"
        static let museums = "Музеи"
        static let parks = "Парки"
        
    }
    
    // MARK: - Views
    enum Views {
        static let search = "Поиск"
        static let sights = "Достопримечательность"
        static let transport = "Транспорт"
        static let relax = "Досуг"
        static let market = "Рынок"
        static let beach = "Пляж"
        static let worship = "Богослужение"
        static let travelGuide = "Маршрут"
        static let toFeatures = "В избранное"
        static let makeCall = "Позвонить"
        static let share = "Поделиться"
        static let toSite = "Сайт"
    }
    
    enum Errors {
        static let locationError = "Location Error"
        static let ok = "OK"
        static let internetError = "Ошибка интернета"
        static let turnOnInternet = "Включите интернет"
        static let settings = "Настройки"
        static let close = "Закрыть"
        static let allowLocationPermision = "Please Allow the Location Permision to get weather of your city"
        static let allowLocationOnDevice = "Please Turn ON the location services on your device"
        
    }
}
