//
//  IntrestingEventsWorker.swift
//  TabBarTest
//
//  Created by ViceCode on 14.12.2021.
//

import Foundation

class IntrestingEventsWorker {
    
    // Запрос на интересные события
    static func updateInterestingEvents(model: ModelForRequest, completion: @escaping()->()) {
        NetworkHelper.shared.makeRequestWithCompletion(type: .events, model: model) {
            completion()
        }    
    }
}
