//
//  MainFloatingView.swift
//  TabBarTest
//
//  Created by ViceCode on 18.10.2021.
//

import UIKit

protocol MainFloatingViewDelegate: AnyObject {
    func closeFloatingView()
}

class MainFloatingView: UIView {
    
    // MARK: - Public properties
    
    weak var delegate: MainFloatingViewDelegate?
    
    // MARK: - UI properties
    
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
        button.imageView?.image = UIImage(systemName: "delete.left.fill")
        button.imageView?.tintColor = .lightGray
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(closeFloatingView), for: .touchUpInside)
        return button
    }()
    // TODO: - TODO
    let buttonsView = ActionButtonsScrollView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: UIScreen.main.bounds.width,
                                                            height: 60))
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.separatorStyle = .singleLine
        table.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        table.allowsSelection = false
        table.register(FloatingViewTableViewCell.self, forCellReuseIdentifier: <#T##String#>)
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
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    
    private func configureUI() {
        self.backgroundColor = .white
        addSubview(imageView)
        addSubview(indicatorView)
        addSubview(closeButton)
        
        
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
        indicatorView.centerX(inView: self)
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
        closeButton.anchor(top: imageView.bottomAnchor,
                           left: nil,
                           bottom: nil,
                           right: rightAnchor,
                           paddingTop: 8,
                           paddingLeft: 0,
                           paddingBottom: 8,
                           paddingRight: 0,
                           width: 35,
                           height: 35)
    }
    
    // MARK: - Selectors
    
    @objc private func closeFloatingView() {
        delegate?.closeFloatingView()
    }
    
    
    
}
