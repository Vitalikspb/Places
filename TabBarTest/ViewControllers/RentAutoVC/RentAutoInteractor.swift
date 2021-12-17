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
    
    var rentsName = ""
    var rentsImage = UIImage(named: "gear")!
    var presenter: RentAutoPresentationLogic?
    
    func showRentAuto() {
        // тут запрашиваем у базы всю инфу по текущему городу
        let rentAuto = [RentAutoModels.RentAutoModel(name: "AVIS", image: UIImage(named: "gear")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.RentAutoModel(name: "Hertz", image: UIImage(named: "gear")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.RentAutoModel(name: "Europcar", image: UIImage(named: "gear")!, url: URL(string: "https://RentAuto.ru/")!)]
        
        let rentTaxi = [RentAutoModels.rentTaxi(name: "UBER", image: UIImage(named: "gear")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.rentTaxi(name: "Яндекс", image: UIImage(named: "gear")!, url: URL(string: "https://RentAuto.ru/")!),
                        RentAutoModels.rentTaxi(name: "Ситимобил", image: UIImage(named: "gear")!, url: URL(string: "https://RentAuto.ru/")!)]
        
        presenter?.presentRentAuto(response: RentAutoModels.RentAuto.ViewModel(rentsService: [
            RentAutoModels.serviceAuto(rents: rentAuto, taxi: rentTaxi)
        ]))
    }
}
