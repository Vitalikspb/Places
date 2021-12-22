//
//  CityModels.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import Foundation
import UIKit

enum CityViewModel {
    
    enum CurrentCity {

        // передаем в интерактор
        struct Request { }
        
        // передаем выбранный город в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все описание текущего города который выбрали из вкладки CountyTab
        struct ViewModel {
            var city: String
            var weather: CurrentWeatherSevenDays
        }
    }
}
