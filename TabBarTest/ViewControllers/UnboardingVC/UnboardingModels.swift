//
//  UnboardingModels.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 07.12.2023.
//

import Foundation
import UIKit

enum UnboardingModels {
    
    struct OnboardingModel {
        let id: Int
        let backgroundColor: String
        let mainImage: UIImage
        let title: String
        let subTitle: String
        let nextButtonTitle: String
    }
    
    enum Unboarding {

        struct Request { }
        
        struct Response { }
        
        struct ViewModel {
            var model: [OnboardingModel]
        }
    }
}

