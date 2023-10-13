//
//  BuyCountryInteractor.swift
//  TabBarTest
//
//

import UIKit

protocol SelectedInterestingEventBussinessLogic: AnyObject {
    func showEvent()
}

protocol SelectedInterestingEventDataStore: AnyObject {
    var name: String { get set }
    var images: Dictionary<String, [ImagesArray]>? { get set }
    var description: String { get set }
    var date: String { get set }
}

class SelectedInterestingEventInteractor: SelectedInterestingEventBussinessLogic, SelectedInterestingEventDataStore {
    var images: Dictionary<String, [ImagesArray]>?
    var date: String = ""
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
                    nameEvent: name, mainText: description, image: images, date: date))
        )
    }
    
}

