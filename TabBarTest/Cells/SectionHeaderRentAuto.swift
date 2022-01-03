//
//  SectionHeader.swift
//  TapStore
//

import UIKit

class SectionHeaderRentAuto: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderRentAuto"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 20)
        return label
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
        addSubview(titleLabel)

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
        titleLabel.anchor(top: separatorView.bottomAnchor,
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
