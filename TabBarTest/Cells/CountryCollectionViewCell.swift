//
//  CountryCollectionViewCell.swift
//  TabBarTest
//
//  Created by ViceCode on 21.10.2021.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let image = UIImageView()
    private let title = UILabel()
    private let gradientView = GradientView()
    
    // MARK: -  Public Properties
    
    static let identifier = "CountryCollectionViewCell"
    var cellImage: UIImage = UIImage() {
        didSet {
            image.image = cellImage
        }
    }
    var cellTitle: String = "" {
        didSet {
            title.text = cellTitle
        }
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    
    private func setupUI() {
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .clear
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.backgroundColor = .white
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 40),
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        gradientView.colors = [UIColor.clear, UIColor.black]
        gradientView.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientView.layer.mask = maskLayer
        
        title.textColor = .white
        title.contentMode = .center
        title.textAlignment = .center
        title.backgroundColor = .clear
        title.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        self.backgroundColor = .clear
        self.standartShadow(view: self)
        
        contentView.addSubview(image)
        contentView.addSubview(gradientView)
        contentView.addSubview(title)
    }
    
    private func setupConstraints() {
        image.addConstraintsToFillView(view: contentView)
        gradientView.anchor(top: nil,
                              left: contentView.leftAnchor,
                               bottom: contentView.bottomAnchor,
                               right: contentView.rightAnchor,
                               paddingTop: 0,
                               paddingLeft: 0,
                               paddingBottom: 0,
                               paddingRight: 0,
                               width: 0, height: 40)
        title.anchor(top: nil,
                     left: contentView.leftAnchor,
                      bottom: contentView.bottomAnchor,
                      right: contentView.rightAnchor,
                      paddingTop: 0,
                      paddingLeft: 0,
                      paddingBottom: 0,
                      paddingRight: 0,
                      width: 0, height: 35)
    }
    
    func conigureCell(title: String, image: UIImage) {
        cellImage = image
        cellTitle = title
    }
    
}
