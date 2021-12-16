//
//  BuyCountryPresenter.swift
//  TabBarTest
//
//

import Foundation

protocol SelectedInterestingEventPresentationLogic {
    func presentDescription(response: SelectedInterestingEventViewModel.EventModels.ViewModel)
}

final class SelectedInterestingEventPresenter: SelectedInterestingEventPresentationLogic {
    
    weak var selectedInterestingEventController: SelectedInterestingEventController?
    
    func presentDescription(response: SelectedInterestingEventViewModel.EventModels.ViewModel) {
        selectedInterestingEventController?.displayAllCities(viewModel: response)
    }
}
