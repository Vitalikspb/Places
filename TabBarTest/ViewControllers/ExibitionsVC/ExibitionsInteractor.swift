////
////  ExibitionsInteractor.swift
////  TabBarTest
////
////  Created by VITALIY SVIRIDOV on 13.11.2021.
////
//
//import UIKit
//
//protocol ExibitionsBussinessLogic: AnyObject {
//    func showExibitions()
//}
//
//protocol ExibitionsDataStore: AnyObject {
//    var currentCity: String { get set }
//}
//
//class ExibitionsInteractor: ExibitionsBussinessLogic, ExibitionsDataStore {
//    
//    var currentCity: String = ""
//    var presenter: ExibitionsPresentationLogic?
//    
//    func showExibitions() {
//        // создаем модель из БД из избранного
//        
//        let interestingEvent = [
//            ExibitionsModels.ExibitionsModel(
//                                    image: UIImage(named: "hermitage5")!,
//                                    name: "День в эрмитаже",
//                                    reviewsStar: 4,
//                                    reviewsCount: 125,
//                                    price: 2500,
//                                    duration: "5"),
//                                ExibitionsModels.ExibitionsModel(
//                                    image: UIImage(named: "exhbroof")!,
//                                    name: "Прогулка по крышам",
//                                    reviewsStar: 5,
//                                    reviewsCount: 425,
//                                    price: 2000,
//                                    duration: "2"),
//                                ExibitionsModels.ExibitionsModel(
//                                    image: UIImage(named: "exhbboat")!,
//                                    name: "Прогулка по рекам и каналам Санкт-Петербурга",
//                                    reviewsStar: 3,
//                                    reviewsCount: 89,
//                                    price: 3200,
//                                    duration: "3"),
//                                ExibitionsModels.ExibitionsModel(
//                                    image: UIImage(named: "exhbmistik")!,
//                                    name: "Мистический Санкт-Петербург",
//                                    reviewsStar: 5,
//                                    reviewsCount: 867,
//                                    price: 1500,
//                                    duration: "2"),
//                                ExibitionsModels.ExibitionsModel(
//                                    image: UIImage(named: "exhbrusmuseum")!,
//                                    name: "Русский музей",
//                                    reviewsStar: 5,
//                                    reviewsCount: 265,
//                                    price: 4000,
//                                    duration: "5"),
//                                
//        ]
//        let viewModel = ExibitionsModels.Exibitions.ViewModel(country: currentCity, events: interestingEvent)
//        presenter?.displayExibitions(response: viewModel)
//    }
//}
//
