//
//  CurrentCityInteractor.swift
//  TabBarTest
//
//

import UIKit

protocol CurrentCityBussinessLogic {
    func showCity()
}

protocol CurrentCityDataStore {
    var city: [String] { get set }
    var currentCity: String { get set }
}

class CurrentCityInteractor: CurrentCityBussinessLogic, CurrentCityDataStore {
    
    var currentCity: String = ""
    var city: [String] = ["Текущий", "Москва", "Санкт-Петербург", "Сочи", "Омск", "Краснодар", "Саратов"]
    
    var presenter: CurrentCityPresentationLogic?

    func showCity() {
//        Здесь создаем модель для текукщего города - заполняем модель все информацией -
//        погодой,
//        главными картинкам,
//        описанием
//        ссылками кнопок
//        местами
//        другими городами
//        по этой модели будем заполнять экран а не как сейчас
        var viewModel = CurrentCityViewModel.AllCitiesInCurrentCountry.ViewModel(cities: [CurrentCityViewModel.CityModel(name: "", image: UIImage())])
        viewModel.cities.removeFirst()
        city.forEach {
            guard let image = UIImage(named: "hub3") else { return }
            viewModel.cities.append(CurrentCityViewModel.CityModel(name: $0, image: image))
        }
        presenter?.presentAllMarkers(response: viewModel)
    }
    
}

