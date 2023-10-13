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
    var city: String { get set }
    var country: String { get set }
}

class IntrestingEventsInteractor: IntrestingEventsBussinessLogic, IntrestingEventsDataStore {
    
    var city: String = ""
    var country: String = ""
    var presenter: IntrestingEventsPresentationLogic?
    
    func showIntrestingEvents() {
        // создаем модель из БД из избранного
        if country == "" {
            country = "Россия"
        }
        IntrestingEventsWorker.updateInterestingEvents(
            model: ModelForRequest(country: country, city: city)) {
                let interestingEvent = UserDefaults.standard.getEvents()
                let viewModel = IntrestingEventsModels.IntrestingEvents.ViewModel(events: interestingEvent)
                self.presenter?.presentIntrestingEvents(response: viewModel)
            }
    }
    
}
