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
    var images: [String] { get set }
    var description: String { get set }
    var date: String { get set }
}

class SelectedInterestingEventInteractor: SelectedInterestingEventBussinessLogic, SelectedInterestingEventDataStore {
    var images: [String] = []
    var date: String = ""
    var name: String = ""
    var description: String = ""
    var presenter: SelectedInterestingEventPresentationLogic?
    
    func showEvent() {
        presenter?.presentDescription(
            response: SelectedInterestingEventViewModel.EventModels.ViewModel(
                event: SelectedInterestingEventViewModel.EventModel(
                    nameEvent: name, mainText: description, image: images, date: date))
        )
    }
    
}

