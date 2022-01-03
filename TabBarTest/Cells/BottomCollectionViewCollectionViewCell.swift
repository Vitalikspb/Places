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
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private let sightNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        return label
    }()
    private let sightTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        return label
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
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        contentView.addSubview(sightImageView)
        contentView.addSubview(sightNameLabel)
        contentView.addSubview(sightTypeLabel)

        sightImageView.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              bottom: contentView.bottomAnchor,
                              right: nil,
                              paddingTop: 10,
                              paddingLeft: 10,
                              paddingBottom: 10,
                              paddingRight: 0,
                              width: 90, height: 0)
        sightTypeLabel.anchor(top: contentView.topAnchor,
                              left: sightImageView.rightAnchor,
                              bottom: nil,
                              right: contentView.rightAnchor,
                              paddingTop: 8,
                              paddingLeft: 8,
                              paddingBottom: 0,
                              paddingRight: 8,
                              width: 0, height: 40)
        sightNameLabel.anchor(top: sightTypeLabel.bottomAnchor,
                              left: sightImageView.rightAnchor,
                              bottom: nil,
                              right: contentView.rightAnchor,
                              paddingTop: 16,
                              paddingLeft: 8,
                              paddingBottom: 8,
                              paddingRight: 8,
                              width: 0, height: 40)
    }
    
    func conigureCell(type: String, name: String, image: UIImage) {
        sightTypeLabel.text = type
        sightNameLabel.text = name
        sightImageView.image = image
    }
}

