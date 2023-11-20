//
//  CellModels.swift
//  TabBarTest
//
//  Created by ViceCode on 29.12.2021.
//

import Foundation
import UIKit
import CoreLocation

struct SightsModel {
    var categoryType: CategoryTypeSight
    var typeSight: TypeSight
    var name: String
    var image: String
    var coordinates: CLLocationCoordinate2D
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
