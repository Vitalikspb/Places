//
//  FAQInteractor.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import UIKit

protocol FAQBussinessLogic: AnyObject {
    func showFAQ()
}

protocol FAQDataStore: AnyObject {
    var city: String { get set }
    var country: String { get set }
}

class FAQInteractor: FAQBussinessLogic, FAQDataStore {
    
    var city: String = ""
    var country: String = ""
    
    var presenter: FAQPresentationLogic?
    
    func showFAQ() {
        if country == "" {
            country = "Россия"
        }
        FAQWorker.updateFAQCity(model: ModelForRequest(country: country, city: city)) {
            let faqCity = UserDefaults.standard.getFAQCity()
            self.presenter?.presentFAQ(response: faqCity)
        }
        
    }
}

