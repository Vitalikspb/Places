//
//  DescriptionCountryToBuyPresenter.swift
//  TabBarTest
//
//  Created by ViceCode on 16.12.2021.
//

import Foundation

protocol DescriptionCountryToBuyPresentationLogic {
    func presentCountry(response: String)
}

final class DescriptionCountryToBuyPresenter: DescriptionCountryToBuyPresentationLogic {
    
    weak var descriptionCountryToBuyController: DescriptionCountryToBuyController?
    
    func presentCountry(response: String) {
        descriptionCountryToBuyController?.displayCurrentCountry(viewModel: response)
    }
}
