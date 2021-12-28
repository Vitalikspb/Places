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
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()

    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 16)
        return label
    }()
    private let citySightCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans", size: 14)
        return label
    }()
    let showSelectedCityButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.contentMode = .right
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "GillSans-Semibold", size: 15)
        button.setTitle("Посмотреть", for: .normal)
        return button
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
    
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        contentView.addSubview(sightImageView)
        contentView.addSubview(citySightCountLabel)
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(showSelectedCityButton)
        
        showSelectedCityButton.layer.cornerRadius = 30
        showSelectedCityButton.layer.borderWidth = 2
        showSelectedCityButton.layer.borderColor = UIColor.lightGray.cgColor
        showSelectedCityButton.addTarget(self, action: #selector(handleTapShowSelectedCity), for: .touchUpInside)
        
        sightImageView.anchor(top: contentView.topAnchor,
                              left: contentView.leftAnchor,
                              bottom: contentView.bottomAnchor,
                              right: nil,
                              paddingTop: 8,
                              paddingLeft: 0,
                              paddingBottom: 8,
                              paddingRight: 0,
                              width: 60, height: 0)
        cityNameLabel.anchor(top: contentView.topAnchor,
                              left: sightImageView.rightAnchor,
                              bottom: nil,
                              right: showSelectedCityButton.leftAnchor,
                              paddingTop: 16,
                              paddingLeft: 8,
                              paddingBottom: 0,
                              paddingRight: 8,
                              width: 0, height: 0)
        citySightCountLabel.anchor(top: cityNameLabel.bottomAnchor,
                              left: sightImageView.rightAnchor,
                              bottom: nil,
                              right: showSelectedCityButton.leftAnchor,
                              paddingTop: 8,
                              paddingLeft: 8,
                              paddingBottom: 16,
                              paddingRight: 8,
                              width: 0, height: 0)
        
        showSelectedCityButton.centerY(inView: contentView)
        showSelectedCityButton.anchor(top: nil,
                                left: nil,
                                bottom: nil,
                                right: contentView.rightAnchor,
                                paddingTop: 0,
                                paddingLeft: 0,
                                paddingBottom: 0,
                                paddingRight: 8,
                                width: 110, height: 60)
    }
    func configureCell(type: String, name: String, image: UIImage) {
        cityNameLabel.text = type
        citySightCountLabel.text = name
        sightImageView.image = image
    }
    
    @objc func handleTapShowSelectedCity() {
        print(cityNameLabel.text ?? "")
        delegate?.showSelected(show: cityNameLabel.text ?? "")
    }
}

