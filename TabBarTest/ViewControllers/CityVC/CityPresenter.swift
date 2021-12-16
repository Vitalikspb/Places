//
//  CityPresenter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import Foundation

protocol CityPresentationLogic {
    func presentCity(response: String)
}

final class CityPresenter: CityPresentationLogic {
    weak var cityController: CityController?
    
    func presentCity(response: String) {
        cityController?.displayCurrentCity(viewModel: response)
    }
    
}
