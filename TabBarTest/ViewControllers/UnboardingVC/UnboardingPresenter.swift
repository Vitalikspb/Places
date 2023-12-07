//
//  UnboardingPresenter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 07.12.2023.
//

import Foundation

protocol UnboardingPresentationLogic: AnyObject {
    func presentUnboarding(response: UnboardingModels.Unboarding.ViewModel)
}

final class UnboardingPresenter: UnboardingPresentationLogic {
    
    weak var unboardingController: UnboardingController?
    
    func presentUnboarding(response: UnboardingModels.Unboarding.ViewModel) {
        unboardingController?.displayUnboarding(viewModel: response)
    }
}
