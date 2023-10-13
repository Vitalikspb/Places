//
//  FAQPresenter.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import Foundation

protocol FAQPresentationLogic: AnyObject {
    func presentFAQ(response: [FAQCity])
}

final class FAQPresenter: FAQPresentationLogic {
    
    weak var faqController: FAQController?
    
    func presentFAQ(response: [FAQCity]) {
        faqController?.displayFAQ(viewModel: response)
    }
    
    
}
