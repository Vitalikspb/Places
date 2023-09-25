//
//  CountryCellsCitiesCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit


class SightCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let title: UILabel = {
       let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.contentMode = .bottom
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        return label
    }()
    
    private let favouriteView: UIView = {
        let view = UIView()
        view.backgroundColor = .setCustomColor(color: .mainView)
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let imageFavourite: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = .setCustomColor(color: .titleText)
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "favouriteImage")
        return imageView
    }()
    
    // MARK: - Private properties
    
    private var putToFavouritesList: Bool = false
    
    // MARK: - Public properties
    
    static let identifier = "SightCollectionViewCell"
    var cellImage: UIImage = UIImage() {
        didSet {
            image.image = cellImage
        }
    }
    var cellTitle: String = "" {
        didSet {
            title.text = cellTitle
        }
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Helper functions
    
    private func setupUI() {
        self.backgroundColor = .clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFavouriteHandle))
        imageFavourite.isUserInteractionEnabled = true
        imageFavourite.addGestureRecognizer(tap)
        
        favouriteView.backgroundColor = putToFavouritesList
        ? .setCustomColor(color: .tabBarIconSelected)
        : .setCustomColor(color: .mainView)
        contentView.addSubviews(image, title, favouriteView)
        favouriteView.addSubviews(imageFavourite)
    }
    
    @objc private func tapFavouriteHandle() {
        putToFavouritesList = !putToFavouritesList
        favouriteView.backgroundColor = putToFavouritesList ? .setCustomColor(color: .tabBarIconSelected) : .setCustomColor(color: .mainView)
    }
    
    private func setupConstraints() {
        image.anchor(top: contentView.topAnchor,
                      left: contentView.leftAnchor,
                      bottom: nil,
                      right: contentView.rightAnchor,
                      paddingTop: 0,
                      paddingLeft: 0,
                      paddingBottom: 0,
                      paddingRight: 0,
                      width: 0, height: 0)
        
        title.anchor(top: image.bottomAnchor,
                     left: contentView.leftAnchor,
                     bottom: contentView.bottomAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: 10,
                     paddingLeft: 0,
                     paddingBottom: 4,
                     paddingRight: 4,
                     width: 0, height: 24)
        
        favouriteView.anchor(top: image.topAnchor,
                             left: nil,
                             bottom: nil,
                             right: image.rightAnchor,
                             paddingTop: 8,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 8,
                             width: 35, height: 35)
        
        imageFavourite.anchor(top: nil,
                              left: nil,
                              bottom: nil,
                              right: nil,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 35, height: 35)
        imageFavourite.center(inView: favouriteView) 
    }
    
    func conigureCell(name: String, image: UIImage) {
        cellImage = image
        cellTitle = name
    }

}

