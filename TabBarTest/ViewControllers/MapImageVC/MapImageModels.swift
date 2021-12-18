//
//  MapImageModels.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.12.2021.
//

import Foundation
import UIKit

enum MapImageModels {
    
    enum MapImageModel {

        // передаем в интерактор
        struct Request { }
        
        // передаем выбранный город в перезнтер для последующего отображения на экране
        struct Response {
            var nameOfMap: String
            var mapImage: String
        }
        
        // посылаем все описание текущего города который выбрали из вкладки CountyTab
        struct ViewModel {
            var nameOfMap: String
            var mapImage: UIImage
        }
    }
}
