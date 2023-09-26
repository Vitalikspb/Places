//
//  SectionHeader.swift
//  TapStore
//

import UIKit

class SectionHeaderRentAuto: UICollectionReusableView {
    
    
    // MARK: - UI properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .semibold, andSize: 20)
        return label
    }()
    
    // MARK: - Public properties
    
    static let reuseIdentifier = "SectionHeaderRentAuto"
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        addSubviews(titleLabel)
        
        titleLabel.anchor(top: self.topAnchor,
                          left: self.leftAnchor,
                          bottom: nil,
                          right: self.rightAnchor,
                          paddingTop: 10,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 0,
                          height: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Stop trying to make storyboards happen.")
    }
}
