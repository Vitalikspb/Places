//
//  SectionHeader.swift
//  TapStore
//

import UIKit

protocol SectionHeaderDelegate: AnyObject {
    func showCountyToBuy(countryName: String)
}

class SectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeader"
    
    let countryNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 20)
        return label
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans", size: 16)
        return label
    }()
    let showSelectedCityButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "GillSans-Semibold", size: 15)
        button.setTitle("Посмотреть", for: .normal)
        return button
    }()
    let separatorView: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        return separator
    }()
    
    weak var delegate: SectionHeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addSubview(separatorView)
        addSubview(countryNameLabel)
        addSubview(subTitleLabel)
        addSubview(showSelectedCityButton)
        
        showSelectedCityButton.addTarget(self, action: #selector(handleSelectCountry), for: .touchUpInside)
        
        separatorView.anchor(top: self.topAnchor,
                             left: self.leftAnchor,
                             bottom: nil,
                             right: self.rightAnchor,
                             paddingTop: 3,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0,
                             height: 1)
        countryNameLabel.anchor(top: separatorView.bottomAnchor,
                                left: self.leftAnchor,
                                bottom: nil,
                                right: showSelectedCityButton.leftAnchor,
                                paddingTop: 10,
                                paddingLeft: 16,
                                paddingBottom: 0,
                                paddingRight: 16,
                                width: 0,
                                height: 25)
        subTitleLabel.anchor(top: countryNameLabel.bottomAnchor,
                             left: self.leftAnchor,
                             bottom: self.bottomAnchor,
                             right: showSelectedCityButton.leftAnchor,
                             paddingTop: 8,
                             paddingLeft: 16,
                             paddingBottom: 10,
                             paddingRight: 16,
                             width: 0,
                             height: 25)
        showSelectedCityButton.centerY(inView: self)
        showSelectedCityButton.anchor(top: nil,
                                      left: nil,
                                      bottom: nil,
                                      right: self.rightAnchor,
                                      paddingTop: 0,
                                      paddingLeft: 0,
                                      paddingBottom: 0,
                                      paddingRight: 16,
                                      width: 130,
                                      height: 60)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Stop trying to make storyboards happen.")
    }
    
    @objc private func handleSelectCountry() {
        delegate?.showCountyToBuy(countryName: countryNameLabel.text ?? "")
    }
}
