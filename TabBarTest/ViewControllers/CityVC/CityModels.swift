//
//  CityModels.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import Foundation
import UIKit

enum CityViewModel {

    enum AllCountriesInTheWorld {

        // передаем в интерактор
        struct Request { }
        
        // передаем все города в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все города для отображения на экране
        struct ViewModel {
            var titlesec: TitleSection
            var model: [SightDescription]?
        }
    }
    
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
