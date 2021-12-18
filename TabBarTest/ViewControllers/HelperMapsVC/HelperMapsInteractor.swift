//
//  HelperMapsInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.12.2021.
//

import UIKit

protocol HelperMapsBussinessLogic {
    func showHelperMaps()
}

protocol HelperMapsDataStore {
    var currentCity: String { get set }
}

class HelperMapsInteractor: HelperMapsBussinessLogic, HelperMapsDataStore {
    
    var currentCity: String = ""
    var mapImage: UIImage = UIImage(named: "hub3")!
    var presenter: HelperMapsPresentationLogic?
    
    func showHelperMaps() {
        // тут запрашиваем у базы всю инфу по текущему городу
        presenter?.presentHelperMaps(
            response: HelperMapsModels.HelperMaps.ViewModel(
                currentCity: currentCity, helperMapsModel: [
                    HelperMapsModels.HelperMapsModel(
                        name: "Карта метро",
                        image: mapImage,
                        url: URL(string: "https://mySite.ru/France/MetroMap/metromap.jpg")!),
                    HelperMapsModels.HelperMapsModel(
                        name: "Карта автобусов",
                        image: mapImage,
                        url: URL(string: "https://mySite.ru/France/AutobusMap/autobusmap.jpg")!),
                    HelperMapsModels.HelperMapsModel(
                        name: "Карта центра города",
                        image: mapImage,
                        url: URL(string: "https://mySite.ru/France/CenterMap/centermap.jpg")!),
                ]
            )
        )
    }
}
