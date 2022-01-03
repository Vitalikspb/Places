//
//  TicketsCellsCitiesCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

class TicketsCellsCitiesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    weak var delegate: CountryCellsCitiesCollectionViewCellDelegate?
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
    
    private let image = UIImageView()
    private let title = UILabel()
    private let gradientView = GradientView()
    let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    private let priceLabel = UILabel()
    private let separatorLeft = UIView()
    let ratingStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.spacing = 0
        stack.axis = .horizontal
        return stack
    }()
    private let ratingImage = UIImageView()
    private let ratingLabel = UILabel()
    private let separatorRight = UIView()
    private let reviewsLabel = UILabel()
    
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
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.backgroundColor = .white
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 50),
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        gradientView.colors = [UIColor.clear, UIColor.black]
        gradientView.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientView.layer.mask = maskLayer
        
        title.textColor = .white
        title.contentMode = .center
        title.textAlignment = .left
        title.backgroundColor = .clear
        title.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        
        
        priceLabel.textColor = UIColor(white: 1.0, alpha: 0.85)
        priceLabel.contentMode = .center
        priceLabel.textAlignment = .left
        priceLabel.backgroundColor = .clear
        priceLabel.font = UIFont.init(name: "GillSans", size: 13)
        
        separatorLeft.backgroundColor = UIColor(white: 1.0, alpha: 0.85)
        
        ratingImage.image = UIImage(systemName: "star.fill")
        ratingImage.contentMode = .scaleAspectFit
        ratingImage.tintColor = .yellow
        
        ratingLabel.textColor = UIColor(white: 1.0, alpha: 0.85)
        ratingLabel.contentMode = .center
        ratingLabel.textAlignment = .left
        ratingLabel.backgroundColor = .clear
        ratingLabel.font = UIFont.init(name: "GillSans", size: 13)
        
        separatorRight.backgroundColor = UIColor(white: 1.0, alpha: 0.85)
        
        reviewsLabel.textColor = UIColor(white: 1.0, alpha: 0.85)
        reviewsLabel.contentMode = .center
        reviewsLabel.textAlignment = .left
        reviewsLabel.backgroundColor = .clear
        reviewsLabel.font = UIFont.init(name: "GillSans", size: 13)
        
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        
        contentView.addSubview(image)
        contentView.addSubview(gradientView)
        contentView.addSubview(title)
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(priceLabel)
        mainStackView.addArrangedSubview(separatorLeft)
        mainStackView.addArrangedSubview(ratingStackView)
        mainStackView.addArrangedSubview(separatorRight)
        mainStackView.addArrangedSubview(reviewsLabel)
        
        ratingStackView.addArrangedSubview(ratingImage)
        ratingStackView.addArrangedSubview(ratingLabel)
        
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
                     bottom: nil,
                     right: contentView.rightAnchor,
                     paddingTop: 0,
                     paddingLeft: 8,
                     paddingBottom: 0,
                     paddingRight: 0,
                     width: 0, height: 25)
        ratingImage.anchor(top: nil,
                           left: nil,
                           bottom: nil,
                           right: nil,
                           paddingTop: 0,
                           paddingLeft: 0,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 20, height: 20)
        separatorRight.anchor(top: nil,
                           left: nil,
                           bottom: nil,
                           right: nil,
                           paddingTop: 0,
                           paddingLeft: 0,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 2, height: 15)
        separatorLeft.anchor(top: nil,
                           left: nil,
                           bottom: nil,
                           right: nil,
                           paddingTop: 0,
                           paddingLeft: 0,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 2, height: 15)
        mainStackView.anchor(top: title.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  bottom: contentView.bottomAnchor,
                                  right: contentView.rightAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 8,
                                  paddingBottom: 8,
                                  paddingRight: 8,
                                  width: 0, height: 15)
       

    }
    
    func configureCell(title: String, image: UIImage, price: Int, rating: Double, reviews: Int) {
        cellImage = image
        cellTitle = title
        priceLabel.text = "\(price) Р."
        ratingLabel.text = "\(rating)"
        reviewsLabel.text = "\(Constants.Cells.reviews): \(reviews)"
    }
    
}

