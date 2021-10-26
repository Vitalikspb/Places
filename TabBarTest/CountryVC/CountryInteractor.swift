//
//  CountryInteractor.swift
//  TabBarTest
//
//  Created by ViceCode on 21.10.2021.
//

import UIKit

protocol CountryBussinessLogic {
    func showCity()
}

protocol CountryDataStore {
    var city: [String] { get set }
}

class CountryInteractor: CountryBussinessLogic {

    var presenter: CountryPresentationLogic?
    var worker = CountryWorker()
    var allCities: [String] = ["Текущий", "Москва", "Санкт-Петербург", "Сочи", "Омск", "Краснодар", "Саратов"]
    
    func showCity() {
        var viewModel = CountryViewModel.AllCitiesInCurrentCountry.ViewModel(cities: [CountryViewModel.CityModel(name: "", image: UIImage())])
        viewModel.cities.removeFirst()
        allCities.forEach {
            guard let image = UIImage(named: "new-york") else { return }
            viewModel.cities.append(CountryViewModel.CityModel(name: $0, image: image))
        }
        presenter?.presentAllMarkers(response: viewModel)
    }
    
}

