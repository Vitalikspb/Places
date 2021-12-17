//
//  RentAutoModels.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import Foundation

import Foundation
import UIKit

enum RentAutoModels {
    
    struct ServiceAuto {
        var rents: [RentAutoModel]
        var taxi: [RentTaxi]
    }
    struct RentTaxi {
        let name: String
        let image: UIImage
        let url: URL
    }
    struct RentAutoModel {
        let name: String
        let image: UIImage
        let url: URL
    }
    
    enum RentAuto {

        // передаем в интерактор
        struct Request { }
        
        // передаем выбранный город в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все описание текущего города который выбрали из вкладки CountyTab
        struct ViewModel {
            var rentsService: ServiceAuto
        }
    }
}
