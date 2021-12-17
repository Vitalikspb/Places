//
//  FAQPresenter.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import Foundation

protocol FAQPresentationLogic {
    func presentFAQ(response: FAQModels.RentAuto.ViewModel)
}

final class FAQPresenter: FAQPresentationLogic {
    
    weak var faqController: FAQController?
    
    func presentFAQ(response: FAQModels.RentAuto.ViewModel) {
        faqController?.displayFAQ(viewModel: response)
    }
    
    
}
