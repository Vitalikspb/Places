//
//  FavouritesRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import Foundation

protocol FavouritesRoutingLogic: AnyObject {
}

protocol FavouritesDataPassing: AnyObject {
}

class FavouritesRouter: NSObject, FavouritesRoutingLogic, FavouritesDataPassing {
    
  weak var viewController: FavouritesController?
    
}
