//
//  CountryCellsPhotosCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

class CountryCellsPhotosCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    static let identifier = "CountryCellsPhotosCollectionViewCell"
    
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
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.backgroundColor = .white

        contentView.addSubview(image)
        image.addConstraintsToFillView(view: contentView)
    }
    
    func configureCell(data: UIImage) {
        image.image = data
    }
    
}
