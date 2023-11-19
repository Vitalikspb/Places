//
//  WorldRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol WorldRoutingLogic: AnyObject {
//    func routeToCountryVC()
    func routeToCityVC()
}

protocol WorldDataPassing: AnyObject {
    var dataStore: WorldDataStore? { get set }
}

class WorldRouter: NSObject, WorldRoutingLogic, WorldDataPassing {
    
    weak var viewController: WorldController?
    var dataStore: WorldDataStore?
    
    // MARK: - Роутинг
    
    // на экран выбранного города
    func routeToCityVC() {
        let destinationVC: CityController = CityController.loadFromStoryboard()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToLeadMore(source: dataStore!, destination: &destinationDS)
        navigateToViewContact(source: viewController!, destination: destinationVC)
    }
    
    // MARK: - Навигация
    
    // открыть следующий город по тыку на ячееке с городами
    func navigateToViewContact(source: WorldController, destination: CityController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Передача данных
    
    func passDataToLeadMore(source: WorldDataStore, destination: inout CityDataStore) {
        destination.currentCity = source.currentCountry
        var tempData: CityViewModel.AllCountriesInTheWorld.ViewModel!
        
        guard let data = source.worldsCountry?[0].model else { return }
        
        for (_,val) in data.enumerated() {
            if val.name == destination.currentCity {
                let dataModel = source.worldsCountry?[0].titlesec
                let tempTitlesec = TitleSection(country: dataModel?.country ?? "",
                                                subTitle: dataModel?.subTitle ?? "",
                                                latitude: dataModel?.latitude ?? 0.0,
                                                longitude: dataModel?.longitude ?? 0.0,
                                                available: dataModel?.available ?? true,
                                                iconName: dataModel?.iconName ?? "")
                let tempModel = SightDescription(id: val.id,
                                                 name: val.name,
                                                 description: val.description,
                                                 price: val.price,
                                                 sight_count: val.sight_count,
                                                 latitude: val.latitude,
                                                 longitude: val.longitude,
                                                 images: val.images)
                tempData = CityViewModel.AllCountriesInTheWorld.ViewModel(titlesec: tempTitlesec,
                                                                          model: [tempModel])
            }
        }
        destination.cityInfo = tempData
    }
    
}

