//
//  WorldInteractor.swift
//  TabBarTest
//
//

import UIKit

protocol WorldBussinessLogic {
    func showCity()
}

protocol WorldDataStore {
    var city: [String] { get set }
    var currentCity: String { get set }
}

class WorldInteractor: WorldBussinessLogic, WorldDataStore {
    
    // выбранная страна куда будет осуществляться переход
    var currentCity: String = ""
    // список всех стран которые есть в приложении
    var city: [String] = ["Россия", "США", "Франция", "Италия", "Германия", "Испания"]
    
    var presenter: WorldPresentationLogic?
    
    func showCity() {
        //        adasd
        //        Здесь создаем модель для текукщего города - заполняем модель все информацией -
        //        погодой,
        //        главными картинкам,
        //        описанием
        //        ссылками кнопок
        //        местами
        //        другими городами
        //        по этой модели будем заполнять экран а не как сейчас
        var viewModel = WorldViewModels.AllCountriesInTheWorld.ViewModel(country: [WorldViewModels.WorldModel(name: "", image: UIImage(named: "hub3")!)])
        viewModel.country.removeFirst()
        city.forEach {
            guard let image = UIImage(named: "hub3") else { return }
            viewModel.country.append(WorldViewModels.WorldModel(name: $0, image: image))
        }
        presenter?.presentAllMarkers(response: viewModel)
    }
    
}

