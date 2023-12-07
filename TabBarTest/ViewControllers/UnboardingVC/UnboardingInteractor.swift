//
//  UnboardingInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 07.12.2023.
//

import UIKit

protocol UnboardingBussinessLogic: AnyObject {
    func showUnboarding()
}

protocol UnboardingDataStore: AnyObject {
    var description: [String] { get set }
    var images: [UIImage] { get set }
}

class UnboardingInteractor: UnboardingBussinessLogic, UnboardingDataStore {
    
    func showUnboarding() {
        print("UnboardingInteractor + showUnboarding")
        showWeather()
    }
    
    var description: [String] = []
    
    var images: [UIImage] = []
    
    

    var presenter: UnboardingPresentationLogic?
    
    func showWeather() {
        presenter?.presentUnboarding(response: UnboardingModels.Unboarding.ViewModel(description: description, images: images))
    }
}
