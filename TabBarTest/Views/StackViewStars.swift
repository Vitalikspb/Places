//
//  StackViewStars.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 04.11.2021.
//

import UIKit

class StackViewStar: UIView {
    
    // MARK: - UI properties
    
    private lazy var wrapperView = UIView()
    private lazy var stackView = UIView()
    private lazy var image1 = UIImageView()
    private lazy var image2 = UIImageView()
    private lazy var image3 = UIImageView()
    private lazy var image4 = UIImageView()
    private lazy var image5 = UIImageView()
    
    // MARK: - private properties
    
    private var countOfRatingStars: Int = 5
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    
    public func show(with count: Int) {
        switch count {
        case 1:
            image2.isHidden = true
            image3.isHidden = true
            image4.isHidden = true
            image5.isHidden = true
            countOfRatingStars = count
            
        case 2:
            image3.isHidden = true
            image4.isHidden = true
            image5.isHidden = true
            countOfRatingStars = count
            
        case 3:
            image4.isHidden = true
            image5.isHidden = true
            countOfRatingStars = count
            
        case 4:
            image5.isHidden = true
            countOfRatingStars = count
            
        case 5:
            countOfRatingStars = count
            
        default:
            print("error")
        }
    }
    
    private func setupView() {
        stackView.addSubview(image1)
        stackView.addSubview(image2)
        stackView.addSubview(image3)
        stackView.addSubview(image4)
        stackView.addSubview(image5)
        
        addSubview(wrapperView)
        wrapperView.addSubview(stackView)
        
        wrapperView.backgroundColor = .clear
        stackView.backgroundColor = .clear
        
        [image1, image2, image3, image4, image5].forEach {
            $0.image = UIImage(named: "star")
            $0.isHidden = false
        }
    }
    
    
    private func setupConstraints() {
        
        wrapperView.anchor(top: nil,
                           left: nil,
                           bottom: nil,
                           right: nil,
                           paddingTop: 0,
                           paddingLeft: 0,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: CGFloat(countOfRatingStars * 25), height: 20)
        stackView.anchor(top: topAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0, height: 0)
        image1.anchor(top: topAnchor,
                      left: leftAnchor,
                      bottom: bottomAnchor,
                      right: nil,
                      paddingTop: 0,
                      paddingLeft: 5,
                      paddingBottom: 0,
                      paddingRight: 0,
                      width: 20, height: 20)
        image2.anchor(top: topAnchor,
                      left: image1.rightAnchor,
                      bottom: bottomAnchor,
                      right: nil,
                      paddingTop: 0,
                      paddingLeft: 5,
                      paddingBottom: 0,
                      paddingRight: 0,
                      width: 20, height: 20)
        image3.anchor(top: topAnchor,
                      left: image2.rightAnchor,
                      bottom: bottomAnchor,
                      right: nil,
                      paddingTop: 0,
                      paddingLeft: 5,
                      paddingBottom: 0,
                      paddingRight: 0,
                      width: 20, height: 20)
        image4.anchor(top: topAnchor,
                      left: image3.rightAnchor,
                      bottom: bottomAnchor,
                      right: nil,
                      paddingTop: 0,
                      paddingLeft: 5,
                      paddingBottom: 0,
                      paddingRight: 0,
                      width: 20, height: 20)
        image5.anchor(top: topAnchor,
                      left: image4.rightAnchor,
                      bottom: bottomAnchor,
                      right: rightAnchor,
                      paddingTop: 0,
                      paddingLeft: 5,
                      paddingBottom: 0,
                      paddingRight: 0,
                      width: 20, height: 20)
    }
}
