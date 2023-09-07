//
//  HelperMapsPresenter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.12.2021.
//

import Foundation

protocol HelperMapsPresentationLogic: AnyObject {
    func presentHelperMaps(response: HelperMapsModels.HelperMaps.ViewModel)
}

final class HelperMapsPresenter: HelperMapsPresentationLogic {
    
    weak var helperMapsController: HelperMapsController?
    
    func presentHelperMaps(response: HelperMapsModels.HelperMaps.ViewModel) {
        helperMapsController?.displayHelperMaps(viewModel: response)
    }
}
