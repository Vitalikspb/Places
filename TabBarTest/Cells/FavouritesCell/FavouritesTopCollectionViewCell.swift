//
//  FavouritesTopCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

// Класс ячейки для всего списка достопримечательнойстей
// отображается сверху экрана сохраненных достопримечательностей
class FavouritesTopCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let sightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private let favouriteFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = .yellow
        imageView.backgroundColor = .clear
        imageView.image = UIImage(systemName: "star")
        return imageView
    }()
    private let sightNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        return label
    }()
    private let sightCityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        return label
    }()
    private let gradientView = GradientView()
    
    // MARK: - Public properties
    
    static let identifier = "FavouritesTopCollectionViewCell"
    private var putToFavouritesList: Bool = true
    
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        contentView.updateShadow(cornerRadius: 8)
    }
    
    // MARK: - Helper functions
    
    private func setupUI() {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 50),
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        gradientView.colors = [UIColor.clear, UIColor.black]
        gradientView.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientView.layer.mask = maskLayer
        
        self.backgroundColor = .red
        contentView.standartShadow(cornerRadius: 8)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFavouriteHandle))
        favouriteFlag.isUserInteractionEnabled = true
        favouriteFlag.addGestureRecognizer(tap)
        favouriteFlag.image = self.putToFavouritesList ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        contentView.addSubview(sightImageView)
        contentView.addSubview(gradientView)
        contentView.addSubview(sightNameLabel)
        contentView.addSubview(sightCityLabel)
        contentView.addSubview(favouriteFlag)
    }
    
    @objc private func tapFavouriteHandle() {
        print("Put to favourite list")
        putToFavouritesList = !putToFavouritesList
        favouriteFlag.image = self.putToFavouritesList ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }
    
    private func setupConstraints() {
        sightImageView.addConstraintsToFillView(view: contentView)
        gradientView.anchor(top: nil,
                            left: contentView.leftAnchor,
                            bottom: contentView.bottomAnchor,
                            right: contentView.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0, height: 50)
        sightNameLabel.anchor(top: nil,
                               left: contentView.leftAnchor,
                               bottom: sightCityLabel.topAnchor,
                               right: contentView.rightAnchor,
                               paddingTop: 0,
                               paddingLeft: 8,
                               paddingBottom: 0,
                               paddingRight: 0,
                               width: 0, height: 25)
        sightCityLabel.anchor(top: nil,
                                  left: contentView.leftAnchor,
                                  bottom: contentView.bottomAnchor,
                                  right: contentView.rightAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 8,
                                  paddingBottom: 8,
                                  paddingRight: 0,
                                  width: 0, height: 20)
        favouriteFlag.anchor(top: contentView.topAnchor,
                            left: nil,
                            bottom: nil,
                            right: contentView.rightAnchor,
                            paddingTop: 4,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 4,
                            width: 35, height: 35)
    }
    func conigureCell(city: String, name: String, image: UIImage, favouritesFlag: Bool) {
        sightNameLabel.text = name
        sightCityLabel.text = city
        sightImageView.image = image
        favouriteFlag.image = favouritesFlag ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
    }
}

