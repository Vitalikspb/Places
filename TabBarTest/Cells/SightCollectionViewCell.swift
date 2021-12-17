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
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private let imageFavourite: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = .yellow
        imageView.backgroundColor = .clear
        imageView.image = UIImage(systemName: "star")
        return imageView
    }()
    private let title = UILabel()
    private let gradientView = GradientView()
    
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
    
    private var putToFavouritesList: Bool = false
    
    
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
        
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0,
                                                    width: contentView.frame.width, height: 50),
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        gradientView.colors = [UIColor.clear, UIColor.red]
        gradientView.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientView.layer.mask = maskLayer
        
        title.textColor = .white
        title.contentMode = .bottom
        title.textAlignment = .left
        title.backgroundColor = .clear
        title.numberOfLines = 0
        title.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFavouriteHandle))
        imageFavourite.isUserInteractionEnabled = true
        imageFavourite.addGestureRecognizer(tap)
        imageFavourite.image = self.putToFavouritesList ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.standartShadow(view: self)
        
        
        contentView.addSubview(image)
        contentView.addSubview(gradientView)
        contentView.addSubview(title)
        contentView.addSubview(imageFavourite)
    }
    
    @objc private func tapFavouriteHandle() {
        putToFavouritesList = !putToFavouritesList
        imageFavourite.image = putToFavouritesList ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }
    
    private func setupConstraints() {
        image.addConstraintsToFillView(view: contentView)
        gradientView.anchor(top: nil,
                            left: contentView.leftAnchor,
                            bottom: contentView.bottomAnchor,
                            right: contentView.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0, height: 50)
        title.anchor(top: nil,
                     left: contentView.leftAnchor,
                     bottom: contentView.bottomAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: 0,
                     paddingLeft: 8,
                     paddingBottom: 0,
                     paddingRight: 8,
                     width: 0, height: 50)
        imageFavourite.anchor(top: contentView.topAnchor,
                              left: nil,
                              bottom: nil,
                              right: contentView.rightAnchor,
                              paddingTop: 4,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 4,
                              width: 35, height: 35)
    }
    
    func conigureCell(name: String, image: UIImage) {
        cellImage = image
        cellTitle = name
    }

}

