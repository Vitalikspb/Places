//
//  FAQInteractor.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import UIKit

protocol FAQBussinessLogic: AnyObject {
    func showFAQ()
    func showTitleName()
}

protocol FAQDataStore: AnyObject {
    var city: String { get set }
    var country: String { get set }
}

class FAQInteractor: FAQBussinessLogic, FAQDataStore {
    
    var city: String = ""
    var country: String = ""
    
    var presenter: FAQPresentationLogic?
    
    func showTitleName() {
        presenter?.presentTitleName(response: city)
    }
    
    func showFAQ() {
        country = "Россия"
        FAQWorker.updateFAQCity(model: ModelForRequest(country: country, city: city)) {
            let faqCity = UserDefaults.standard.getFAQCity()
            print("faqCity:\(faqCity)")
            self.presenter?.presentFAQ(response: faqCity)
        }
        
    }
}

