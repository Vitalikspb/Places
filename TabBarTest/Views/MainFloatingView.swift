//
//  MainFloatingView.swift
//  TabBarTest
//
//  Created by ViceCode on 18.10.2021.
//

import UIKit

class MainFloatingView: UIView {
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3
        view.alpha = 0.8
        return view
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "new-york")
        return imageView
    }()
    
//    cell 1
//    let titleNameLabel
//    let addressTopLabel
//    let typeLabel
//    let openLabel
//    let whenClosedToday
    
//    let actionButtonsScrollView
//    let favouriteButton
//    let routeButton
//    let cellButton
//    let shareButton
//    let siteButton
    
//    cell 2
//    let additionalImagesScrollView
    
//    cell 3
//    let addressTitleLabel
//    let addressLabel
    
//    cell 4
//    let contactTitlelabel
//    let phoneLabel
//    let siteLabel
    
//    cell 5
//    let scheduleTitleLabel
//    let scheduleLabel
//    let scheduleButton
//    let scheduleView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        addSubview(imageView)
        addSubview(indicatorView)
        

        imageView.anchor(top: topAnchor,
                             left: leftAnchor,
                             bottom: nil,
                             right: rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0,
                             height: (UIScreen.main.bounds.height/4))
        
        indicatorView.anchor(top: imageView.bottomAnchor,
                             left: nil,
                             bottom: nil,
                             right: nil,
                             paddingTop: 8,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 80,
                             height: 6)
        indicatorView.centerX(inView: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
