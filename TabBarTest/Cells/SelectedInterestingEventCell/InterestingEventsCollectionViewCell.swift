//
//  CountryCellsCitiesCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit


class InterestingEventsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    // MARK: - Public properties
    
    static let identifier = "InterestingEventsCollectionViewCell"

    
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
        backgroundColor = .white
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        contentView.addSubview(mainImageView)
        mainImageView.addConstraintsToFillView(view: contentView)
    }
    
    func conigureCell(image: String) {
        NetworkHelper.shared.downloadImage(from: image) { image in
            self.mainImageView.image = image
        }
    }
    
}

