//
//  TicketsCellsCitiesCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

class ExibitionsTableViewCell: UITableViewCell {

    // MARK: - Private properties
    
    private let mainImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private let title: UILabel = {
       let title = UILabel()
        title.textColor = .white
        title.contentMode = .center
        title.textAlignment = .left
        title.backgroundColor = .clear
        title.font = UIFont.init(name: "GillSans-SemiBold", size: 20)
        return title
    }()
    private let gradientView = GradientView()
    let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(white: 1.0, alpha: 0.85)
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans", size: 13)
        return label
    }()
    private let separatorLeft: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.85)
        return view
    }()
    let ratingStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.spacing = 0
        stack.axis = .horizontal
        return stack
    }()
    private let ratingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .yellow
        return image
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 1.0, alpha: 0.85)
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans", size: 13)
        return label
    }()
    private let separatorRight: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.85)
        return view
    }()
    private let reviewsLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(white: 1.0, alpha: 0.85)
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans", size: 13)
        return label
    }()
    private let durationLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(white: 1.0, alpha: 0.85)
        label.contentMode = .center
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans", size: 13)
        return label
    }()
    
    // MARK: - Public properties
    
    static let identifier = "ExibitionsTableViewCell"
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
        
        contentView.addSubview(mainImageView)
        contentView.addSubview(gradientView)
        contentView.addSubview(title)
        contentView.addSubview(mainStackView)
        contentView.addSubview(durationLabel)
        
        mainStackView.addArrangedSubview(priceLabel)
        mainStackView.addArrangedSubview(separatorLeft)
        mainStackView.addArrangedSubview(ratingStackView)
        mainStackView.addArrangedSubview(separatorRight)
        mainStackView.addArrangedSubview(reviewsLabel)
        
        ratingStackView.addArrangedSubview(ratingImage)
        ratingStackView.addArrangedSubview(ratingLabel)

        mainImageView.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             bottom: contentView.bottomAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 8,
                             paddingLeft: 16,
                             paddingBottom: 8,
                             paddingRight: 16,
                             width: 0, height: 0)
        gradientView.anchor(top: nil,
                            left: contentView.leftAnchor,
                            bottom: contentView.bottomAnchor,
                            right: contentView.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 16,
                            paddingBottom: 8,
                            paddingRight: 16,
                            width: 0, height: 50)
        title.anchor(top: nil,
                     left: contentView.leftAnchor,
                     bottom: contentView.bottomAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: 0,
                     paddingLeft: 32,
                     paddingBottom: 45,
                     paddingRight: 32,
                     width: 0, height: 25)
        durationLabel.anchor(top: contentView.topAnchor,
                             left: nil,
                             bottom: nil,
                             right: contentView.rightAnchor,
                             paddingTop: 16,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 32,
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
        mainStackView.anchor(top: nil,
                                  left: contentView.leftAnchor,
                                  bottom: contentView.bottomAnchor,
                                  right: contentView.rightAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 32,
                                  paddingBottom: 21,
                                  paddingRight: 32,
                                  width: 0, height: 15)
       

    }
    func configureCell(name: String, image: UIImage, reviewsStar: Int, reviewsCount: Int, price: Int, duration: String) {
        title.text = name
        mainImageView.image = image
        priceLabel.text = "\(price) Р."
        ratingLabel.text = "\(reviewsCount)"
        reviewsLabel.text = "\(Constants.Cells.reviews): \(reviewsStar)"
        durationLabel.text = duration + "h"
    }
    
}

