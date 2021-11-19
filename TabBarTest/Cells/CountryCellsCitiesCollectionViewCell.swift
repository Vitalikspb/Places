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
            numberOfSightLabel.text = "Мест: \(cellNumberOfSight)"
        }
    }
    
    // MARK: - Private properties
    
    private let image = UIImageView()
    private let title = UILabel()
    private let gradientView = GradientView()
    private let numberOfSightLabel = UILabel()
    let moveToChoosenCityButton = UIButton()
    private let latitude = 59.88422
    private let longitude = 30.2545
    
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
        
        numberOfSightLabel.textColor = UIColor(white: 1.0, alpha: 0.85)
        numberOfSightLabel.contentMode = .center
        numberOfSightLabel.textAlignment = .left
        numberOfSightLabel.backgroundColor = .clear
        numberOfSightLabel.font = UIFont.init(name: "GillSans", size: 13)
        
        moveToChoosenCityButton.setImage(UIImage(systemName: "map"), for: .normal)
        moveToChoosenCityButton.backgroundColor = .clear
        moveToChoosenCityButton.tintColor = .white
        moveToChoosenCityButton.addTarget(self, action: #selector(moveToMapViewHandle), for: .touchUpInside)
        moveToChoosenCityButton.layer.cornerRadius = 8
        
        
        self.backgroundColor = .red
        self.layer.cornerRadius = 8
        self.standartShadow(view: self)
        
        
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
                                       left: nil,
                                       bottom: contentView.bottomAnchor,
                                       right: contentView.rightAnchor,
                                       paddingTop: 0,
                                       paddingLeft: 0,
                                       paddingBottom: 0,
                                       paddingRight: 0,
                                       width: 50, height: 50)
    }
    
    func conigureCell(title: String, image: UIImage) {
        cellImage = image
        cellTitle = title
        cellNumberOfSight = 15
    }
    
    // MARK: - Selectors
    
    @objc private func moveToMapViewHandle() {
        let from = self.cellTitle
        switch from {
        case "Москва": delegate?.handleSelectedCity(55.7529517, 37.6232801)
        case "Санкт-Петербург": delegate?.handleSelectedCity(59.9396340, 30.3104843)
        default:
            break
        }
    }
}

