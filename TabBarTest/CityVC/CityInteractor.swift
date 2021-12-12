//
//  CityInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol CityBussinessLogic {
    func showCity()
}

protocol CityDataStore {
    var currentCity: String { get set }
}

class CityInteractor: CityBussinessLogic, CityDataStore {
    
    var currentCity: String = ""
    var presenter: CityPresentationLogic?
    
    func showCity() {
        presenter?.presentCity(response: currentCity)
    }
}

