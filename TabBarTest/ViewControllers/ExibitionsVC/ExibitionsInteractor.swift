//
//  ExibitionsInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol ExibitionsBussinessLogic {
    func showExibitions()
}
//
//protocol FavouritesDataStore {
//    var citiesArray: [String] { get set }
//}

class ExibitionsInteractor: ExibitionsBussinessLogic {
    
    var presenter: ExibitionsPresentationLogic?
    
    func showExibitions() {
        // создаем модель из БД из избранного
        
        let interestingEvent = [ExibitionsModels.ExibitionsModel(image: UIImage(named: "hub3")!,
                                                                 name: "День в эрмитаже",
                                                                 reviewsStar: 4,
                                                                 reviewsCount: 125,
                                                                 price: 2500,
                                                                 duration: "5"),
                                ExibitionsModels.ExibitionsModel(image: UIImage(named: "hub3")!,
                                                                                         name: "Прогулка по крышам",
                                                                                         reviewsStar: 5,
                                                                                         reviewsCount: 425,
                                                                                         price: 2000,
                                                                                         duration: "2"),
                                ExibitionsModels.ExibitionsModel(image: UIImage(named: "hub3")!,
                                                                                         name: "Прогулка по рекам и каналам Санкт-Петербурга",
                                                                                         reviewsStar: 3,
                                                                                         reviewsCount: 89,
                                                                                         price: 3200,
                                                                                         duration: "3"),
                                ExibitionsModels.ExibitionsModel(image: UIImage(named: "hub3")!,
                                                                                         name: "Мистический Санкт-Петербург",
                                                                                         reviewsStar: 5,
                                                                                         reviewsCount: 867,
                                                                                         price: 1500,
                                                                                         duration: "2"),
                                ExibitionsModels.ExibitionsModel(image: UIImage(named: "hub3")!,
                                                                                         name: "Русский музей",
                                                                                         reviewsStar: 5,
                                                                                         reviewsCount: 265,
                                                                                         price: 4000,
                                                                                         duration: "5"),
                               
        ]
        let viewModel = ExibitionsModels.Exibitions.ViewModel(events: interestingEvent)
        presenter?.displayExibitions(response: viewModel)
    }
}

