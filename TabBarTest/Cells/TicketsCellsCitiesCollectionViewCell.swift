//
//  TicketsCellsCitiesCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol TicketsCellsCitiesCollectionViewCellDelegate: AnyObject {
    func openGuidesUrl(url: String)
}

class TicketsCellsCitiesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    weak var delegate: TicketsCellsCitiesCollectionViewCellDelegate?
    static let identifier = "TicketsCellsCitiesCollectionViewCell"
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
    
    // MARK: - Private properties
    
    private let image: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        return label
    }()
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .regular, andSize: 16)
        return label
    }()
    private let ratingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.contentMode = .center
        return imageView
    }()
    private let ratingLabel: UILabel = {
       let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        return label
    }()
    private let reviewsLabel: UILabel = {
       let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .regular, andSize: 16)
        return label
    }()
    
    private var url: String?
    
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
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        contentView.addSubviews(image, title, ratingImage, ratingLabel, priceLabel, reviewsLabel)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func tapHandle() {
        delegate?.openGuidesUrl(url: url ?? "")
    }
    
    private func setupConstraints() {
        image.anchor(top: contentView.topAnchor,
                      left: contentView.leftAnchor,
                      bottom: title.topAnchor,
                      right: contentView.rightAnchor,
                      paddingTop: 0,
                      paddingLeft: 0,
                      paddingBottom: 2,
                      paddingRight: 0,
                      width: 0, height: 0)
        title.anchor(top: nil,
                     left: contentView.leftAnchor,
                     bottom: priceLabel.topAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: 4,
                     paddingLeft: 4,
                     paddingBottom: 0,
                     paddingRight: 4,
                     width: 0, height: 50)
        priceLabel.anchor(top: nil,
                          left: contentView.leftAnchor,
                          bottom: contentView.bottomAnchor,
                          right: nil,
                          paddingTop: 0,
                          paddingLeft: 0,
                          paddingBottom: 8,
                          paddingRight: 0,
                          width: 0, height: 25)
        reviewsLabel.anchor(top: nil,
                          left: priceLabel.rightAnchor,
                          bottom: contentView.bottomAnchor,
                          right: nil,
                          paddingTop: 0,
                          paddingLeft: 0,
                          paddingBottom: 8,
                          paddingRight: 0,
                          width: 0, height: 25)

        
        ratingImage.anchor(top: nil,
                           left: nil,
                           bottom: contentView.bottomAnchor,
                           right: nil,
                           paddingTop: 0,
                           paddingLeft: 0,
                           paddingBottom: 13,
                           paddingRight: 0,
                           width: 16, height: 16)
        ratingLabel.anchor(top: nil,
                           left: ratingImage.rightAnchor,
                           bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor,
                           paddingTop: 0,
                           paddingLeft: 4,
                           paddingBottom: 10,
                           paddingRight: 0,
                           width: 35, height: 0)
    }
    
    func configureCell(title: String, image: UIImage, price: Int, rating: Double, reviews: Int, url: String) {
        cellImage = image
        cellTitle = title
        priceLabel.text = "\(price) ₽ / "
        ratingLabel.text = "\(rating)"
        reviewsLabel.text = "\(Constants.Cells.reviews): \(reviews)"
        self.url = url
    }
    
}

