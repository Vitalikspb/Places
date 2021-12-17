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
    var name: String { get set }
    var image: [UIImage] { get set }
    var description: String { get set }
}

class SelectedInterestingEventInteractor: SelectedInterestingEventBussinessLogic, SelectedInterestingEventDataStore {
    
    var image: [UIImage] = []
    var name: String = ""
    var description: String = ""
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
        
        presenter?.presentDescription(
            response: SelectedInterestingEventViewModel.EventModels.ViewModel(
                event: SelectedInterestingEventViewModel.EventModel(
                    nameEvent: name, mainText: description, image: image))
        )
    }
    
}

