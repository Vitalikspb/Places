//
//  BuyCountryInteractor.swift
//  TabBarTest
//
//

import UIKit

protocol BuyCountryBussinessLogic {
    func showCity()
}

protocol BuyCountryDataStore {
    var city: [String] { get set }
    var currentCity: String { get set }
}

class BuyCountryInteractor: BuyCountryBussinessLogic, BuyCountryDataStore {
    
    var currentCity: String = ""
    var city: [String] = ["Текущий", "Москва", "Санкт-Петербург", "Сочи", "Омск", "Краснодар", "Саратов"]
    
    var presenter: BuyCountryPresentationLogic?

    func showCity() {
//        Здесь создаем модель для текукщего города - заполняем модель все информацией -
//        погодой,
//        главными картинкам,
//        описанием
//        ссылками кнопок
//        местами
//        другими городами
//        по этой модели будем заполнять экран а не как сейчас
        var viewModel = BuyCountryViewModel.AllCitiesInCurrentCountry.ViewModel(cities: [BuyCountryViewModel.CityModel(name: "", image: UIImage())])
        viewModel.cities.removeFirst()
        city.forEach {
            guard let image = UIImage(named: "hub3") else { return }
            viewModel.cities.append(BuyCountryViewModel.CityModel(name: $0, image: image))
        }
        presenter?.presentAllMarkers(response: viewModel)
    }
    
}

