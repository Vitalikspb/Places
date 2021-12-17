//
//  CountryCellsCitiesCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol CountryCellsCitiesCollectionViewCellDelegate: AnyObject {
    func handleSelectedCity(_ lat : Double, _ lon: Double)
}

class CountryCellsCitiesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        return label
    }()
    private let gradientView = GradientView()
    private let numberOfSightLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 1.0, alpha: 0.85)
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans", size: 13)
        return label
    }()
    private let moveToChoosenCityButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.Cells.toMap, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .bottom
        button.titleLabel?.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        return button
    }()
    
    private let latitude = 59.88422
    private let longitude = 30.2545
    
    // MARK: - Public properties
    
    weak var delegate: CountryCellsCitiesCollectionViewCellDelegate?
    static let identifier = "CountryCellsCitiesCollectionViewCell"
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
    var cellNumberOfSight: Int = 0 {
        didSet {
            numberOfSightLabel.text = "\(Constants.Cells.countSights): \(cellNumberOfSight)"
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

        moveToChoosenCityButton.addTarget(self, action: #selector(moveToMapViewHandle), for: .touchUpInside)
        
        self.backgroundColor = .red
        contentView.standartShadow(cornerRadius: 8)
        
        contentView.addSubview(image)
        contentView.addSubview(gradientView)
        contentView.addSubview(title)
        contentView.addSubview(numberOfSightLabel)
        contentView.addSubview(moveToChoosenCityButton)
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
                     right: moveToChoosenCityButton.leftAnchor,
                     paddingTop: 0,
                     paddingLeft: 8,
                     paddingBottom: 0,
                     paddingRight: 0,
                     width: 0, height: 25)
        numberOfSightLabel.anchor(top: title.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  bottom: contentView.bottomAnchor,
                                  right: moveToChoosenCityButton.leftAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 8,
                                  paddingBottom: 8,
                                  paddingRight: 0,
                                  width: 0, height: 20)
        moveToChoosenCityButton.anchor(top: nil,
                                       left: numberOfSightLabel.rightAnchor,
                                       bottom: contentView.bottomAnchor,
                                       right: contentView.rightAnchor,
                                       paddingTop: 0,
                                       paddingLeft: 8,
                                       paddingBottom: 4,
                                       paddingRight: 8,
                                       width: 0, height: 40)
    }
    
    func conigureCell(title: String, image: UIImage) {
        cellImage = image
        cellTitle = title
        cellNumberOfSight = 15
    }
    
    // MARK: - Selectors
    
    @objc private func moveToMapViewHandle() {
        switch cellTitle {
        case "Москва": delegate?.handleSelectedCity(55.7529517, 37.6232801)
        case "Санкт-Петербург": delegate?.handleSelectedCity(59.9396340, 30.3104843)
        default:
            break
        }
    }
}

