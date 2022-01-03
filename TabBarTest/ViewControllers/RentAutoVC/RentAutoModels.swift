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
    
    struct ServiceAuto: Hashable {
        var titlesec: TitleSection
        var rents: [AutoModel]
    }
    struct AutoModel: Hashable {
        let name: String
        let image: UIImage
        let url: URL
    }
    struct TitleSection: Hashable {
        var title: String
    }
    
    enum RentAuto {

        // передаем в интерактор
        struct Request { }
        
        // передаем выбранный город в перезнтер для последующего отображения на экране
        struct Response { }
        
        // посылаем все описание текущего города который выбрали из вкладки CountyTab
        struct ViewModel {
            var rentsService: [ServiceAuto]
        }
    }
}
