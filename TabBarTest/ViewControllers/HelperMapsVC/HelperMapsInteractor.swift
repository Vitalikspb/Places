//
//  HelperMapsInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.12.2021.
//

import UIKit

protocol HelperMapsBussinessLogic: AnyObject {
    func showHelperMaps()
}

protocol HelperMapsDataStore: AnyObject {
    var currentCity: String { get set }
    var preImage: String { get set }
    var name: String { get set }
    var stringURL: String { get set }
}

class HelperMapsInteractor: HelperMapsBussinessLogic, HelperMapsDataStore {
    
    var currentCity: String = ""
    
    var preImage: String = ""
    var name: String = ""
    var stringURL: String = ""
    
    var presenter: HelperMapsPresentationLogic?
    
    func showHelperMaps() {
        // тут запрашиваем у базы всю инфу по текущему городу
        presenter?.presentHelperMaps(
            response: HelperMapsModels.HelperMaps.ViewModel(
                currentCity: currentCity, helperMapsModel: [
                    HelperMapsModels.HelperMapsModel(
                        name: "Карта метро",
                        image: UIImage(named: "mapmetro")!,
                        url: "hub3"),
                    HelperMapsModels.HelperMapsModel(
                        name: "Карта автобусов",
                        image: UIImage(named: "mapbus")!,
                        url: "hub3"),
                    HelperMapsModels.HelperMapsModel(
                        name: "Карта центра города",
                        image: UIImage(named: "mapcenter")!,
                        url: "hub3"),
                ]
            )
        )
    }
}
