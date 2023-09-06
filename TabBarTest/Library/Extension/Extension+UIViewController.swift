//
//  Extension+UIViewController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 16.11.2021.
//

import UIKit

extension UIViewController {
    
    /// Расширение для загрузки viewController из storyboard
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: id, bundle: .main)
        return storyboard.instantiateViewController(identifier: id) as! T
    }
}
