//
//  CountryInteractor.swift
//  TabBarTest
//
//

import UIKit

protocol CountryBussinessLogic {
    func showCity()
}

protocol CountryDataStore {
    var city: [String] { get set }
    var currentCity: String { get set }
}

class CountryInteractor: CountryBussinessLogic, CountryDataStore {
    
    var currentCity: String = ""
    var city: [String] = ["Текущий", "Москва", "Санкт-Петербург", "Сочи", "Омск", "Краснодар", "Саратов"]
    
    var presenter: CountryPresentationLogic?

    func showCity() {
        var viewModel = CountryViewModel.AllCitiesInCurrentCountry.ViewModel(cities: [CountryViewModel.CityModel(name: "", image: UIImage())])
        viewModel.cities.removeFirst()
        city.forEach {
            guard let image = UIImage(named: "new-york") else { return }
            viewModel.cities.append(CountryViewModel.CityModel(name: $0, image: image))
        }
        presenter?.presentAllMarkers(response: viewModel)
    }
    
}

