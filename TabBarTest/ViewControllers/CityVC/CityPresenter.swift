//
//  CityPresenter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import Foundation

protocol CityPresentationLogic {
    func presentCity(response: CityViewModel.CurrentCity.ViewModel)
}

final class CityPresenter: CityPresentationLogic {
    
    weak var cityController: CityController?
    
    func presentCity(response: CityViewModel.CurrentCity.ViewModel) {
        cityController?.displayCurrentCity(viewModel: response)
    }
}
