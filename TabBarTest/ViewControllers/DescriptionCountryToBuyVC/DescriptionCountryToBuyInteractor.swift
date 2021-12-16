//
//  DescriptionCountryToBuyInteractor.swift
//  TabBarTest
//
//  Created by ViceCode on 16.12.2021.
//

import UIKit

protocol DescriptionCountryToBuyBussinessLogic {
    func showCity()
}

protocol DescriptionCountryToBuyDataStore {
    var currentCountry: String { get set }
}

class DescriptionCountryToBuyInteractor: DescriptionCountryToBuyBussinessLogic, DescriptionCountryToBuyDataStore {
    
    var currentCountry: String = ""
    var presenter: DescriptionCountryToBuyPresentationLogic?
    
    func showCity() {
        // тут запрашиваем у базы всю инфу по текущему городу
        presenter?.presentCountry(response: currentCountry)
    }
}
