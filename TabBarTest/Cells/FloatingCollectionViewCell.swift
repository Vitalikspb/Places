//
//  FloatingCollectionViewCell.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 04.11.2021.
//

import UIKit

class FloatingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    static let identifier = "FloatingCollectionViewCell"
    
    // MARK: - Private properties
    
    let image = UIImageView()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        image.backgroundColor = .clear
        image.image = UIImage(named: "hub3")
        
        contentView.addSubview(image)
        
        image.addConstraintsToFillView(view: contentView)
    }
    
}
