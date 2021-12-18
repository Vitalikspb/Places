//
//  HelperMapsModels.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.12.2021.
//

import Foundation
import UIKit

enum HelperMapsModels {
    
    struct HelperMapsModel {
        let name: String
        let image: UIImage
        let url: URL
    }

    enum HelperMaps {

        // передаем в интерактор
        struct Request { }
        
        // передаем выбранный город в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все описание текущего города который выбрали из вкладки CountyTab
        struct ViewModel {
            var currentCity: String
            var helperMapsModel: [HelperMapsModel]
        }
    }
}
