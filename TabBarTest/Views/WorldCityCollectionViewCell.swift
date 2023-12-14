//
//  WorldCityView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 29.09.2023.
//

import UIKit

protocol WorldCityCollectionViewCellDelegate: AnyObject {
    func selectCity(name: String)
    func showCityOnMap(name: String)
}

class WorldCityCollectionViewCell: UICollectionViewCell, Reusable {
    
    // MARK: - UI properties
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let mainImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.tintColor = .setCustomColor(color: .titleText)
        return image
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        return label
    }()
    let numberOfSightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        return label
    }()
    private let moveToChoosenCityView: UIView = {
        let view = UIView()
        view.backgroundColor = .setCustomColor(color: .mainView)
        view.layer.cornerRadius = 6
        return view
    }()
    private let moveToChoosenCityButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = .setCustomColor(color: .titleText)
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "moveToMap")
        return imageView
    }()
    private let animateButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
        return button
    }()
    
    // MARK: - Public properties
    
    weak var delegate: WorldCityCollectionViewCellDelegate?
    static let identifier = "WorldCityCollectionViewCell"
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
    }
    
    // MARK: - Helper functions
    
    func configureCell(withName title: String, sight: Int, andImage image: String, alpha: CGFloat, available: Bool) {
        mainView.alpha = alpha
        titleLabel.text = title
        numberOfSightLabel.text = "\(sight) мест"

        self.mainImageView.image = UIImage(named: image)
        
        [mainImageView, titleLabel, numberOfSightLabel].forEach {
            $0.alpha = alpha
        }
        mainImageView.isUserInteractionEnabled = available
        moveToChoosenCityButton.isUserInteractionEnabled = available
        animateButton.isUserInteractionEnabled = available
    }
    
    private func setupUI() {
        animateButton.delegate = self
        let mapTap = UITapGestureRecognizer(target: self, action: #selector(moveToCityViewHandle))
        mainImageView.addGestureRecognizer(mapTap)
        
        contentView.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        contentView.addSubviews(mainView)
        mainView.addConstraintsToFillView(view: contentView)
        mainView.addSubviews(mainImageView, titleLabel, numberOfSightLabel, animateButton)
        animateButton.addSubviews(moveToChoosenCityView)
        moveToChoosenCityView.addSubviews(moveToChoosenCityButton)

        
        mainImageView.anchor(top: mainView.topAnchor,
                             left: mainView.leftAnchor,
                             bottom: nil,
                             right: mainView.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0, height: 0)
        
        titleLabel.anchor(top: mainImageView.bottomAnchor,
                          left: mainView.leftAnchor,
                          bottom: nil,
                          right: nil,
                          paddingTop: 4,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0, height: 25)
        
        numberOfSightLabel.anchor(top: titleLabel.bottomAnchor,
                                  left: mainView.leftAnchor,
                                  bottom: mainView.bottomAnchor,
                                  right: nil,
                                  paddingTop: 4,
                                  paddingLeft: 16,
                                  paddingBottom: 4,
                                  paddingRight: 0,
                                  width: 0, height: 20)
        animateButton.anchor(top: mainImageView.topAnchor,
                                     left: nil,
                                     bottom: nil,
                                     right: mainImageView.rightAnchor,
                                     paddingTop: 8,
                                     paddingLeft: 0,
                                     paddingBottom: 0,
                                     paddingRight: 8,
                                     width: 35, height: 35)
        moveToChoosenCityView.addConstraintsToFillView(view: animateButton)
        moveToChoosenCityButton.addConstraintsToFillView(view: moveToChoosenCityView)
    }
    
    // MARK: - Selectors
    
    @objc private func moveToCityViewHandle() {
        delegate?.selectCity(name: titleLabel.text ?? "")
    }
    
}

// MARK: - CustomAnimatedButtonDelegate

extension WorldCityCollectionViewCell: CustomAnimatedButtonDelegate {
    
    func continueButton(id: Int) {
        print("переход на город на карте")
        delegate?.showCityOnMap(name: titleLabel.text ?? "")
    }
    
}
