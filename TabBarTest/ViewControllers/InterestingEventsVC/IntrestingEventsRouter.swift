//
//  IntrestingEventsRouter.swift
//  TabBarTest
//
//  Created by ViceCode on 14.12.2021.
//

import Foundation

protocol IntrestingEventsRoutingLogic {
}

protocol IntrestingEventsDataPassing {
}

class IntrestingEventsRouter: NSObject, IntrestingEventsRoutingLogic, IntrestingEventsDataPassing {
    
  weak var viewController: IntrestingEventsController?
    
}
