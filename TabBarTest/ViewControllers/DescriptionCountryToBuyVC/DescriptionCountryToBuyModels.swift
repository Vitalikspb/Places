//
//  DescriptionCountryToBuyModels.swift
//  TabBarTest
//
//  Created by ViceCode on 16.12.2021.
//

import Foundation
import UIKit

enum DescriptionCountryToBuyViewModel {
    
    enum CurrentCountry {

        // передаем в интерактор
        struct Request { }
        
        // передаем выбранный город в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все описание текущего города который выбрали из вкладки CountyTab
        struct ViewModel {
            var city: String
        }
    }
}
