//
//  CountryRouter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit


extension UIViewController {
    // расширение для загрузки viewController из storyboard
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: id, bundle: .main)
        return storyboard.instantiateViewController(identifier: id) as! T
    }
}

// TODO: - тестовая структура
//final class Contact {
//    
//    var title: String
//    var image: String
//    
//    init(title: String = "",
//         image: String = "") {
//        
//        self.title = title
//        self.image = image
//    }
//}


protocol CountryRoutingLogic {
    func routeToCityVC()
}

protocol CountryDataPassing {
    var dataStore: CountryDataStore? { get set }
}

class CountryRouter: NSObject, CountryRoutingLogic {
    
    weak var viewController: CountryController?
    
    // MARK: - Routing
    
    func routeToCityVC() {
        let destinationVC: CityController = CityController.loadFromStoryboard()
        navigateToViewContact(source: viewController!, destination: destinationVC)
    }

    // MARK: - Navigation
    
    func navigateToViewContact(source: CountryController, destination: CityController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
}

