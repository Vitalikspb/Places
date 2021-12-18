//
//  FAQInteractor.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import UIKit

protocol FAQBussinessLogic {
    func showFAQ()
}

protocol FAQDataStore {
    var currentCity: String { get set }
}

class FAQInteractor: FAQBussinessLogic, FAQDataStore {
    
    var currentCity: String = ""
    var presenter: FAQPresentationLogic?
    
    func showFAQ() {
        // тут запрашиваем у базы всю инфу по текущему городу

        
        presenter?.presentFAQ(response: FAQModels.RentAuto.ViewModel(
                                currentCity: currentCity, FAQModel: [
                FAQModels.FAQModel(question: "Как добраться от аэропорта до центра?", answer: "Надо выйти из аэропорта, сесть на 15 автобус до центра"),
                FAQModels.FAQModel(question: "Есть ли в городе метро Есть ли в городе метро Есть ли в городе метро", answer: "Время работы в основном с 09:00 до 22:00 Время работы в основном с 09:00 до 22:00 Время работы в основном с 09:00 до 22:00 Время работы в основном с 09:00 до 22:00"),
                FAQModels.FAQModel(question: "Во сколько закрываются торговые комплексы", answer: "Yes")
            ])
                              )
    }
}

