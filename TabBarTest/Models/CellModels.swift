//
//  CellModels.swift
//  TabBarTest
//
//  Created by ViceCode on 29.12.2021.
//

import Foundation
import UIKit

enum TypeSights: String {
    /// Достопримечательность
    case dostoprimechtelnost = "Достопримечательность"
    /// Транспорт
    case transport = "Транспорт"
    /// Досуг
    case dosug = "Досуг"
    /// Рынок
    case market = "Рынок"
    /// Пляж
    case beach = "Пляж"
    /// Богослужение
    case god = "Богослужение"
}

enum TypeSightsImageName: String {
    /// Достопримечательность
    case museum = "museum"
    /// Транспорт
    case transport = "transport"
    /// Досуг
    case sight = "sight"
    /// Рынок
    case market = "market"
    /// Пляж
    case beach = "beach"
    /// Богослужение
    case temple = "temple"
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
