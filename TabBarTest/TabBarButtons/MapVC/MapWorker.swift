//
//  MapWorker.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 04.10.2021.
//

import Foundation

class MapWorker {
    
    /// Загрузка всех достопримечательностей
    static func downloadAllSight(worldModel: ModelForRequest, completion: @escaping()->()) {
        NetworkHelper.shared.makeRequest(type: .sight, model: .init(country: "Россия")) {
//            print("get sight:\(UserDefaults.standard.getSight())")
            completion()
        }
    }
    
}
