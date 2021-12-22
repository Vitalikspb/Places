//
//  DescriptionCountryToBuyPresenter.swift
//  TabBarTest
//
//  Created by ViceCode on 16.12.2021.
//

import Foundation

protocol DescriptionCountryToBuyPresentationLogic {
    func presentCountry(response: DescriptionCountryToBuyViewModel.CurrentCountry.ViewModel)
}

final class DescriptionCountryToBuyPresenter: DescriptionCountryToBuyPresentationLogic {
    
    weak var descriptionCountryToBuyController: DescriptionCountryToBuyController?
    
    func presentCountry(response: DescriptionCountryToBuyViewModel.CurrentCountry.ViewModel) {
        descriptionCountryToBuyController?.displayCurrentCountry(viewModel: response)
    }
}
