//
//  FAQWorker.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import Foundation

class FAQWorker {
    
    // Запрос на интересные события
    static func updateFAQCity(model: ModelForRequest, completion: @escaping()->()) {
        NetworkHelper.shared.makeRequest(type: .faq, model: model)
        completion()
    }
    
}
