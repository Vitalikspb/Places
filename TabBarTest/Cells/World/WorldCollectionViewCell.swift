//
//  WorldCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol WorldCollectionViewCellDelegate: AnyObject {
    func showSelected(show: String)
}

class WorldCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let sightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        return label
    }()
    private let citySightCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .regular, andSize: 14)
        return label
    }()
    private let buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = .setCustomColor(color: .filterView)
        view.layer.cornerRadius = 6
        return view
    }()
    private let buttonArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "rightArrow")
        return imageView
    }()
    
    // MARK: - Public properties
    
    static let identifier = "WorldCollectionViewCell"
    weak var delegate: WorldCollectionViewCellDelegate?
    
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
    
    func configureCell(type: String, name: String, image: UIImage) {
        cityNameLabel.text = type
        citySightCountLabel.text = name
        sightImageView.image = image
    }
    
    private func setupUI() {
        self.backgroundColor = .setCustomColor(color: .mainView)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        contentView.backgroundColor = .white
        
        contentView.addSubviews(sightImageView, citySightCountLabel, cityNameLabel, buttonView)
        buttonView.addSubviews(buttonArrowImageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapShowSelectedCity))
        buttonArrowImageView.isUserInteractionEnabled = true
        buttonArrowImageView.addGestureRecognizer(tap)
        
        sightImageView.centerY(inView: self)
        sightImageView.anchor(top: nil,
                              left: contentView.leftAnchor,
                              bottom: nil,
                              right: nil,
                              paddingTop: 0,
                              paddingLeft: 8,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 56, height: 56)
        cityNameLabel.anchor(top: contentView.topAnchor,
                             left: sightImageView.rightAnchor,
                             bottom: nil,
                             right: buttonView.leftAnchor,
                             paddingTop: 16,
                             paddingLeft: 8,
                             paddingBottom: 0,
                             paddingRight: 8,
                             width: 0, height: 0)
        citySightCountLabel.anchor(top: cityNameLabel.bottomAnchor,
                                   left: sightImageView.rightAnchor,
                                   bottom: nil,
                                   right: buttonView.leftAnchor,
                                   paddingTop: 8,
                                   paddingLeft: 8,
                                   paddingBottom: 16,
                                   paddingRight: 8,
                                   width: 0, height: 0)
        buttonView.centerY(inView: contentView)
        buttonView.anchor(top: nil,
                          left: nil,
                          bottom: nil,
                          right: contentView.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 8,
                          width: 28, height: 28)
        buttonArrowImageView.addConstraintsToFillView(view: buttonView)
    }
    
    
    
    // MARK: - Selection
    
    @objc func handleTapShowSelectedCity() {
        print(cityNameLabel.text ?? "")
        delegate?.showSelected(show: cityNameLabel.text ?? "")
    }
}

