//
//  WeatherModels.swift
//  TabBarTest
//
//  Created by ViceCode on 21.12.2021.
//

import Foundation
import UIKit

enum WeatherModels {
    
    enum Weather {

        // передаем в интерактор
        struct Request { }
        
        // передаем выбранный город в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все описание текущего города который выбрали из вкладки CountyTab
        struct ViewModel {
            var currentCity: String
            var weather: CurrentWeatherSevenDays
        }
    }
}
