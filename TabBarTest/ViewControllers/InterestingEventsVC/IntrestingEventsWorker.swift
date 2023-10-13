//
//  IntrestingEventsWorker.swift
//  TabBarTest
//
//  Created by ViceCode on 14.12.2021.
//

import Foundation

class IntrestingEventsWorker {
    
    // Запрос на интересные события
    static func updateInterestingEnents(model: ModelForRequest, completion: @escaping()->()) {
        NetworkHelper.shared.makeRequest(type: .events, model: model) {
            completion()
        }
    }
}
