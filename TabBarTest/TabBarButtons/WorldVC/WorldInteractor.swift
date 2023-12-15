//
//  WorldInteractor.swift
//  TabBarTest
//
//

import UIKit

protocol WorldBussinessLogic: AnyObject {
    func showCity()
}

protocol WorldDataStore: AnyObject {
    var currentCountry: String { get set }
    var worldsCountry: [WorldViewModels.AllCountriesInTheWorld.ViewModel]? { get set }
}

class WorldInteractor: WorldBussinessLogic, WorldDataStore {
    
    var worldsCountry: [WorldViewModels.AllCountriesInTheWorld.ViewModel]?
    
    // выбранная страна куда будет осуществляться переход
    var currentCountry: String = ""
    
    var presenter: WorldPresentationLogic?
    
    func showCity() {
        let worldModel = ModelForRequest(country: currentCountry == "" ? "Россия" : currentCountry)
        WorldWorker.updateCountry(model: worldModel) {
            self.sendModel()
        }
    }
    
    private func sendModel() {
        let tempWorldCountry = UserDefaults.standard.getSightDescription()
        var sightCount: Int = 0
        tempWorldCountry.forEach {
            sightCount += $0.sight_count
        }
        worldsCountry = [WorldViewModels.AllCountriesInTheWorld.ViewModel(
            titlesec: TitleSection(country: "Россия",
                                   subTitle: "\(tempWorldCountry.count) городов, \(sightCount) мест",
                                   latitude: 55.755863,
                                   longitude: 37.617700,
                                   available: true,
                                   iconName: "iconRussia"),
            model: tempWorldCountry)]

        if var _worldsCountry = self.worldsCountry {
            WorldWorker.addTestCountries(&_worldsCountry)
            self.presenter?.presentAllMarkers(response: _worldsCountry)
        }
    }

}

