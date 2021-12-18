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
    var mapName: String { get set }
    var mapImage: UIImage { get set }
}

class HelperMapsInteractor: HelperMapsBussinessLogic, HelperMapsDataStore {
    
    var mapName: String = ""
    var mapImage: UIImage = UIImage(named: "hub3")!
    var presenter: HelperMapsPresentationLogic?
    
    func showHelperMaps() {
        // тут запрашиваем у базы всю инфу по текущему городу
        let rentAuto = [RentAutoModels.RentAutoModel(name: "AVIS", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.RentAutoModel(name: "Hertz", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.RentAutoModel(name: "Europcar", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!)]
        
        let rentTaxi = [RentAutoModels.RentTaxi(name: "UBER", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.RentTaxi(name: "Яндекс", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.RentTaxi(name: "Ситимобил", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!)]
        
        presenter.presentHelperMaps
    }
}
