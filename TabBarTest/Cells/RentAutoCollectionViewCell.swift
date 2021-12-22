//
//  RentAutoCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

class RentAutoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
        return label
    }()
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    // MARK: - Public properties
    
    static let identifier = "RentAutoCollectionViewCell"
    
    
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
        contentView.addSubview(mainImageView)
        
        mainImageView.centerX(inView: contentView)
        mainImageView.anchor(top: contentView.topAnchor,
                             left: nil,
                             bottom: nil,
                             right: nil,
                             paddingTop: 35,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 120, height: 120)
        titleLabel.anchor(top: mainImageView.bottomAnchor,
                          left: contentView.leftAnchor,
                          bottom: contentView.bottomAnchor,
                          right: contentView.rightAnchor,
                          paddingTop: 8,
                          paddingLeft: 8,
                          paddingBottom: 8,
                          paddingRight: 8,
                          width: 0,
                          height: 0)
    }
    
    func configureCell(title: String, image: UIImage) {
        titleLabel.text = title
        mainImageView.image = image
    }
}
