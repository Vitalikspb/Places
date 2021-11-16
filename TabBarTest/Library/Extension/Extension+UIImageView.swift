//
//  Extension+UIImageView.swift
//  TabBarTest
//
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
