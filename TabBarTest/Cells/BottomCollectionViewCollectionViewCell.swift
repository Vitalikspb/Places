//
//  BottomCollectionViewCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit


class BottomCollectionViewCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let sightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    private let sightNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.contentMode = .topLeft
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .bold, andSize: 18)
        return label
    }()
    private let sightTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.contentMode = .bottomLeft
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .semibold, andSize: 14)
        return label
    }()
    
    private let sightTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "sun")
        imageView.tintColor = .setCustomColor(color: .tabBarIconSelected)
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    // MARK: - Public properties
    
    static let identifier = "BottomCollectionViewCollectionViewCell"
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Helper functions
    
    private func setupUI() {
        self.backgroundColor = .setCustomColor(color: .mainView)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        contentView.addSubviews(sightImageView, sightNameLabel, sightTypeLabel, sightTypeImageView)

        sightImageView.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              bottom: contentView.bottomAnchor,
                              right: nil,
                              paddingTop: 8,
                              paddingLeft: 8,
                              paddingBottom: 8,
                              paddingRight: 0,
                              width: 72, height: 72)
        sightNameLabel.anchor(top: contentView.topAnchor,
                              left: sightImageView.rightAnchor,
                              bottom: nil,
                              right: contentView.rightAnchor,
                              paddingTop: 21,
                              paddingLeft: 12,
                              paddingBottom: 0,
                              paddingRight: 8,
                              width: 0, height: 0)
        sightTypeLabel.anchor(top: nil,
                              left: sightTypeImageView.rightAnchor,
                              bottom: contentView.bottomAnchor,
                              right: contentView.rightAnchor,
                              paddingTop: 0,
                              paddingLeft: 10,
                              paddingBottom: 21,
                              paddingRight: 8,
                              width: 0, height: 0)
        sightTypeImageView.anchor(top: nil,
                                  left: sightImageView.rightAnchor,
                                  bottom: contentView.bottomAnchor,
                                  right: nil,
                                  paddingTop: 0,
                                  paddingLeft: 16,
                                  paddingBottom: 23,
                                  paddingRight: 0,
                                  width: 16, height: 16)
    }
    
    func conigureCell(type: String, name: String, image: UIImage, typeSight: TypeSightsImageName) {
        sightTypeLabel.text = type
        sightNameLabel.text = name
        sightImageView.image = image
        sightTypeImageView.image = UIImage(named: typeSight.rawValue)
    }
}

