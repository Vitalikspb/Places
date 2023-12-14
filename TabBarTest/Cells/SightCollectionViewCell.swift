//
//  CountryCellsCitiesCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol SightCollectionViewCellDelegate: AnyObject {
    func favoritesTapped(name: String)
}

class SightCollectionViewCell: UICollectionViewCell, Reusable {
    
    // MARK: - UI properties
    
    private var image: UIImageView = {
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
        view.backgroundColor = .clear
        view.layer.cornerRadius = 6
        return view
    }()
    
    private var imageFavourite: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .setCustomColor(color: .titleText)
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "favouriteImage")
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let favouriteButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
        return button
    }()
    
    // MARK: - Private properties
    
    private var putToFavouritesList: Bool = false
    
    // MARK: - Public properties
    
    weak var delegate: SightCollectionViewCellDelegate?
    static let identifier = "SightCollectionViewCell"
    var cellImage: UIImage = UIImage() {
        didSet {
            image.image = cellImage
        }
    }
    var cellSelectedImage: UIImage = UIImage() {
        didSet {
            imageFavourite.image = cellSelectedImage
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
        title.text = ""
        image.image = UIImage()
        imageFavourite.image = UIImage()
    }
    
    // MARK: - Helper functions
    
    func conigureCell(name: String, image: UIImage, favotite: UIImage) {
        cellImage = image
        cellTitle = name
        cellSelectedImage = favotite
        putToFavouritesList = cellSelectedImage == UIImage(named: "AddtofavoritesSelected") ? true : false
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        
        favouriteButton.delegate = self
        contentView.addSubviews(image, title, favouriteButton)
        favouriteButton.addSubviews(favouriteView)
        favouriteView.addSubviews(imageFavourite)
    }
    
    @objc private func tapFavouriteHandle() {
        putToFavouritesList = !putToFavouritesList
        cellSelectedImage = (cellSelectedImage == UIImage(named: "AddtofavoritesSelected")
                             ? UIImage(named: "AddtofavoritesUnselected")
                             : UIImage(named: "AddtofavoritesSelected")) ?? UIImage()
        delegate?.favoritesTapped(name: cellTitle)
    }
    
    private func setupConstraints() {
        image.anchor(top: contentView.topAnchor,
                      left: contentView.leftAnchor,
                     bottom: title.topAnchor,
                      right: contentView.rightAnchor,
                      paddingTop: 10,
                      paddingLeft: 0,
                      paddingBottom: 0,
                      paddingRight: 0,
                      width: 0, height: 0)
        title.anchor(top: nil,
                     left: contentView.leftAnchor,
                     bottom: contentView.bottomAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: 0,
                     paddingLeft: 0,
                     paddingBottom: 4,
                     paddingRight: 4,
                     width: 0, height: 24)
        favouriteButton.anchor(top: image.topAnchor,
                             left: nil,
                             bottom: nil,
                             right: image.rightAnchor,
                             paddingTop: 8,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 8,
                             width: 35, height: 35)
        favouriteView.addConstraintsToFillView(view: favouriteButton)
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

}

// MARK: - CustomAnimatedButtonDelegate

extension SightCollectionViewCell: CustomAnimatedButtonDelegate {
    
    func continueButton(id: Int) {
        tapFavouriteHandle()
    }

}

