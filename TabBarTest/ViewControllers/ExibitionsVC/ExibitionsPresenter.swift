//
//  ExibitionsPresenter.swift
//  TabBarTest
//
//  Created by ViceCode on 14.12.2021.
//

import Foundation

protocol ExibitionsPresentationLogic: AnyObject {
    func displayExibitions(response: ExibitionsModels.Exibitions.ViewModel)
}

final class ExibitionsPresenter: ExibitionsPresentationLogic {
    
    weak var exibitionsController: ExibitionsController?
    
    func displayExibitions(response: ExibitionsModels.Exibitions.ViewModel) {
        exibitionsController?.displayExibitions(viewModel: response)
    } 
}
