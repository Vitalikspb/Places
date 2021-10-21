//
//  Extension+UIImageView.swift
//  TabBarTest
//
//  Created by ViceCode on 21.10.2021.
//

import UIKit

extension UIImageView {
    
    func standartShadow(imageView: UIImageView) {
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.60
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageView.layer.shadowRadius = 2
    }
}
