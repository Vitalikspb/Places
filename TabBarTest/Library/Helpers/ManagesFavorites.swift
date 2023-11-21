//
//  ManagesFavorites.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 21.11.2023.
//

import Foundation

class ManagesFavorites {
    static func updateFavorites(sights: inout [Sight], withName name: String) {
        var newFavorites = true
        var curIndexOfFavorite = -1
        var favorites = UserDefaults.standard.getFavorites()
        for (ind,val) in favorites.enumerated() {
            print("\(val.name) == \(name)")
            
            if val.name == name {
                newFavorites = false
                curIndexOfFavorite = ind
            }
        }
        if newFavorites {
            // если нету в списке избранного, добавляем в список избранного
            if let item = sights.filter({ $0.name == name }).last {
                favorites.append(item)
            }
        } else {
            // если уже есть в списке избранного, удаляем из списока избранного
            favorites.remove(at: curIndexOfFavorite)
        }
        UserDefaults.standard.saveFavorites(value: favorites)
    }
}
