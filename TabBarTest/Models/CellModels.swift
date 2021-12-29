//
//  CellModels.swift
//  TabBarTest
//
//  Created by ViceCode on 29.12.2021.
//

import Foundation
import UIKit

enum TypeSights: String {
    case dostoprimechtelnost = "Достопримечательность"
    case transport = "Транспорт"
    case dosug = "Досуг"
    case market = "Рынок"
    case beach = "Пляж"
    case god = "Богослужение"
    case district = "Район"
}

struct SightsModel {
//    var type: TypeSights
    var name: String
    var image: UIImage
    var favourite: Bool
}

struct CityArray {
    var name: String
    var image: UIImage
}

struct GuideSightsModel {
    var image: UIImage
    var name: String
    var price: Int
    var rating: Double
    var reviews: Int
}
