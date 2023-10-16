//
//  WorldPresenter.swift
//  TabBarTest
//
//

import Foundation

protocol WorldPresentationLogic: AnyObject {
    func presentAllMarkers(response: [WorldViewModels.AllCountriesInTheWorld.ViewModel])
}

final class WorldPresenter: WorldPresentationLogic {
    weak var WorldController: WorldController?
    
    func presentAllMarkers(response: [WorldViewModels.AllCountriesInTheWorld.ViewModel]) {
        WorldController?.displayAllCities(viewModel: response)
    }
    
}
