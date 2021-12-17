//
//  IntrestingEventsPresenter.swift
//  TabBarTest
//
//  Created by ViceCode on 14.12.2021.
//

import Foundation

protocol IntrestingEventsPresentationLogic {
    func presentIntrestingEvents(response: IntrestingEventsModels.IntrestingEvents.ViewModel)
}

final class IntrestingEventsPresenter: IntrestingEventsPresentationLogic {
    weak var intrestingEventsController: IntrestingEventsController?
    
    func presentIntrestingEvents(response: IntrestingEventsModels.IntrestingEvents.ViewModel) {
        intrestingEventsController?.displayIntrestingEvents(viewModel: response)
    }
    
}
