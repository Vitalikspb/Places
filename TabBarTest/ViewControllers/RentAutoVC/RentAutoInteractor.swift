//
//  RentAutoInteractor.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import UIKit

protocol RentAutoBussinessLogic: AnyObject {
    func showRentAuto()
}

protocol RentAutoDataStore: AnyObject {
    var rentsName: String { get set }
    var rentsImage: UIImage { get set }
}

class RentAutoInteractor: RentAutoBussinessLogic, RentAutoDataStore {
    
    var rentsImage: UIImage = UIImage(named: "hub3")!
    var rentsName = ""
    var presenter: RentAutoPresentationLogic?
    
    func showRentAuto() {
        // тут запрашиваем у базы всю инфу по текущему городу
        let rentAuto = [RentAutoModels.AutoModel(name: "AVIS", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.AutoModel(name: "Hertz", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.AutoModel(name: "Europcar", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!)]
        
        let rentTaxi = [RentAutoModels.AutoModel(name: "UBER", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.AutoModel(name: "Яндекс", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.AutoModel(name: "Ситимобил", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!)]
        
        presenter?.presentRentAuto(response:
                                    RentAutoModels.RentAuto.ViewModel(
                                        rentsService: [
                                            RentAutoModels.ServiceAuto(titlesec: RentAutoModels.TitleSection(title: "Аренда авто"), rents: rentAuto),
                                            RentAutoModels.ServiceAuto(titlesec: RentAutoModels.TitleSection(title: "Такси"), rents: rentTaxi)
                                        ]
                                    )
        )
    }
}
