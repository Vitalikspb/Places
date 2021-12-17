//
//  RentAutoInteractor.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import UIKit

protocol RentAutoBussinessLogic {
    func showRentAuto()
}

protocol RentAutoDataStore {
    var rentsName: String { get set }
    var rentsImage: UIImage { get set }
}

class RentAutoInteractor: RentAutoBussinessLogic, RentAutoDataStore {
    var rentsImage: UIImage = UIImage(named: "hub3")!
    
    
    var rentsName = ""
    var presenter: RentAutoPresentationLogic?
    
    func showRentAuto() {
        // тут запрашиваем у базы всю инфу по текущему городу
        let rentAuto = [RentAutoModels.RentAutoModel(name: "AVIS", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.RentAutoModel(name: "Hertz", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.RentAutoModel(name: "Europcar", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!)]
        
        let rentTaxi = [RentAutoModels.RentTaxi(name: "UBER", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.RentTaxi(name: "Яндекс", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.RentTaxi(name: "Ситимобил", image: UIImage(named: "hub3")!, url: URL(string: "https://RentAuto.ru/")!)]
        
        presenter?.presentRentAuto(response: RentAutoModels.RentAuto.ViewModel(rentsService:
            RentAutoModels.ServiceAuto(rents: rentAuto, taxi: rentTaxi)
        ))
    }
}