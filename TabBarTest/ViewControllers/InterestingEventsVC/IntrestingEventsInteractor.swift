//
//  IntrestingEventsInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol IntrestingEventsBussinessLogic: AnyObject {
    func showIntrestingEvents()
}

protocol IntrestingEventsDataStore: AnyObject {
    var name: String { get set }
    var images: [String] { get set }
    var description: String { get set }
    var date: String { get set }
    var city: String { get set }
    var country: String { get set }
}

class IntrestingEventsInteractor: IntrestingEventsBussinessLogic, IntrestingEventsDataStore {
    
    var name: String = ""
    var images: [String] = []
    var description: String = ""
    var date: String = ""
    var city: String = ""
    var country: String = ""
    var presenter: IntrestingEventsPresentationLogic?
    
    func showIntrestingEvents() {
        // создаем модель из БД из избранного
        let model = ModelForRequest(country: "Россия",
                                    city: city)
        IntrestingEventsWorker.updateInterestingEvents(model: model) {
            let interestingEvent = UserDefaults.standard.getEvents()
            let viewModel = IntrestingEventsModels.IntrestingEvents.ViewModel(events: interestingEvent)
            self.presenter?.presentIntrestingEvents(response: viewModel)
        }
    }
    
}
