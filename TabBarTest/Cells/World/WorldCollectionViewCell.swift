//
//  RentAutoCollectionViewCell.swift
//  DiffableDataSource
//
//  Created by ViceCode on 23.12.2021.


import UIKit

class WorldCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
        return label
    }()
    
    // MARK: - Public properties
    
    static let identifier = "WorldCollectionViewCell"
    
    
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
        // Для обрезания длинного текста описания события
        self.clipsToBounds = true
        let bgColorView = UIView()
        bgColorView.backgroundColor = .white
        self.selectedBackgroundView = bgColorView
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        titleLabel.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: subtitleLabel.topAnchor,
                          right: contentView.rightAnchor,
                          paddingTop: 8,
                          paddingLeft: 8,
                          paddingBottom: 8,
                          paddingRight: 8,
                          width: 0,
                          height: 25)
        subtitleLabel.anchor(top: nil,
                             left: contentView.leftAnchor,
                             bottom: contentView.bottomAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 8,
                             paddingBottom: 8,
                             paddingRight: 8,
                             width: 0, height: 25)
        
    }
    
    func configureCell(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
