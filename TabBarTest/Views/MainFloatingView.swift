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
    let closeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    // TODO: - TODO
    private let buttonsView = ActionButtonsScrollView(frame: CGRect(x: 0,
                                                                    y: 0,
                                                                    width: UIScreen.main.bounds.width,
                                                                    height: 60))
 
    
    let tableView: UITableView = {
       let table = UITableView()
        return table
    }()
    
    // cell 1
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let typeLocationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    let imagesScrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    let locationImage: UIImageView = {
       let image = UIImageView()
        return image
    }()
    
    
    // cell 2
//        let titleNameLabel
//        let addressTopLabel
//        let typeLabel
//        let openLabel
//        let whenClosedToday
    let cellImage: UIImageView = {
        let image = UIImageView()
         return image
     }()
    let cellTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    //for cell with work time
    let cellArrowImage: UIImageView = {
        let image = UIImageView()
         return image
     }()
    private var shapeLayer: CALayer?
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
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
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
    
    
    
}
