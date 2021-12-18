//
//  RentAutoPresenter.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import Foundation

protocol RentAutoPresentationLogic {
    func presentRentAuto(response: RentAutoModels.RentAuto.ViewModel)
}

final class RentAutoPresenter: RentAutoPresentationLogic {
    
    weak var rentAutoController: RentAutoController?
    
    func presentRentAuto(response: RentAutoModels.RentAuto.ViewModel) {
        rentAutoController?.displayRentAuto(viewModel: response)
    }
}
