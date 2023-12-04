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
    
    private let sightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sightImageView.image = nil
    }
    
    // MARK: - Helper functions
    
    func configureCell(imageName: String) {
        let name = imageName.components(separatedBy: ".").first ?? ""
        sightImageView.image = UIImage(named: name)
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(sightImageView)
        sightImageView.addConstraintsToFillView(view: contentView)
    }
    
}
