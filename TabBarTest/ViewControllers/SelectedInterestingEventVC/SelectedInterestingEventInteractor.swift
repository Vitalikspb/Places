//
//  BuyCountryInteractor.swift
//  TabBarTest
//
//

import UIKit

protocol SelectedInterestingEventBussinessLogic {
    func showEvent()
}

protocol SelectedInterestingEventDataStore {
    var currentCity: String { get set }
    var image: [UIImage] { get set }
}

class SelectedInterestingEventInteractor: SelectedInterestingEventBussinessLogic, SelectedInterestingEventDataStore {
    
    var image: [UIImage] = []
    var currentCity: String = ""
    var presenter: SelectedInterestingEventPresentationLogic?

    func showEvent() {
//        Здесь создаем модель для текукщего города - заполняем модель все информацией -
//        погодой,
//        главными картинкам,
//        описанием
//        ссылками кнопок
//        местами
//        другими городами
//        по этой модели будем заполнять экран а не как сейчас
        
        
//        presenter?.presentDescription(response: SelectedInterestingEventViewModel.EventModels.ViewModel(event: SelectedInterestingEventViewModel.EventModel(mainText: currentCity, image: image)))
        
        
        presenter?.presentDescription(response: SelectedInterestingEventViewModel.EventModels.ViewModel(event: SelectedInterestingEventViewModel.EventModel(mainText: "новый", image: [UIImage(named: "hub3")!,UIImage(named: "hub3")!])))
    }
    
}

