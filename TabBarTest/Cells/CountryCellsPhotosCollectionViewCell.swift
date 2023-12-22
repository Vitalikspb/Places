//
//  CountryCellsPhotosCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

class CountryCellsPhotosCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    static let identifier = "CountryCellsPhotosCollectionViewCell"
    
    // MARK: - UI properties
    
    private let mainImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    // MARK: - LifeCycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    
    private func setupUI() {
        self.layer.cornerRadius = 12
        contentView.addSubview(mainImageView)
        mainImageView.addConstraintsToFillView(view: contentView)
    }
    
    func configureCell(data: UIImage) {
        mainImageView.image = data
    }
    
}
