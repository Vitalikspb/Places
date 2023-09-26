//
//  SectionHeader.swift
//  TapStore
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    // MARK: - UI properties
    
    let countryNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .bold, andSize: 20)
        return label
    }()
    private let countyIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "iconRussia")
        return imageView
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .regular, andSize: 16)
        return label
    }()
    
    // MARK: - Public properties
    
    static let reuseIdentifier = "SectionHeader"
    
    // MARK: - Life cycle
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Stop trying to make storyboards happen.")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        countryNameLabel.text = ""
        countyIconImageView.image = UIImage(named: "iconRussia")
        subTitleLabel.text = ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .clear
        self.backgroundColor = .white
        addSubviews(countryNameLabel, countyIconImageView, subTitleLabel)
        
        countryNameLabel.anchor(top: self.topAnchor,
                                left: self.leftAnchor,
                                bottom: nil,
                                right: nil,
                                paddingTop: 12,
                                paddingLeft: 16,
                                paddingBottom: 0,
                                paddingRight: 0,
                                width: 0,
                                height: 32)
        countyIconImageView.anchor(top: self.topAnchor,
                                   left: countryNameLabel.rightAnchor,
                                   bottom: nil,
                                   right: nil,
                                   paddingTop: 16,
                                   paddingLeft: 8,
                                   paddingBottom: 0,
                                   paddingRight: 0,
                                   width: 24,
                                   height: 24)
        
        subTitleLabel.anchor(top: countryNameLabel.bottomAnchor,
                             left: self.leftAnchor,
                             bottom: self.bottomAnchor,
                             right: self.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 16,
                             paddingBottom: 10,
                             paddingRight: 16,
                             width: 0,
                             height: 20)
    }
}
