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
//
//protocol CityDataStore {
//    var citiesArray: [String] { get set }
//}

class CityInteractor: CityBussinessLogic {
//    var citiesArray: [String] = ["Текущий", "Москва", "Санкт-Петербург", "Сочи", "Омск", "Краснодар", "Саратов"]
    var currentCity: String = "Текущий"
    var presenter: CityPresentationLogic?
    
    func showCity() {
        guard let currentCity = UserDefaults.standard.string(forKey: UserDefaults.currentCity) else { return }
        let viewModel = CityViewModel.CurrentCity.ViewModel(city: CityViewModel.CityModel(title: currentCity, image: UIImage(named: "new-york")!))
        presenter?.presentCity(response: viewModel)
    }
}

