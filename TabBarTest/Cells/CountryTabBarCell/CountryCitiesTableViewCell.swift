//
//  CountryCitiesTableViewCell.swift
//  TabBarTest
//
//

import UIKit

class CountryCitiesTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private let image = UIImageView()
    private let title = UILabel()
    private let gradientView = GradientView()
    private let numberOfSightLabel = UILabel()
    private let moveToChoosenCityButton = UIButton()
    private let latitude = 59.88422
    private let longitude = 30.2545
    
    // MARK: -  Public Properties
    
    static let identifier = "CountryCitiesTableViewCell"
    var presentMap: ((_ lat : Double, _ lon: Double) -> ())?
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
    
    // MARK: - LifeCycle
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
            setupConstraints()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc private func moveToMapViewHandle() {
        let from = self.cellTitle
        let lat = UserDefaults.standard.double(forKey: UserDefaults.currentLatitude)
        let lon = UserDefaults.standard.double(forKey: UserDefaults.currentLongitude)
        switch from {
        case "Текущий": presentMap?(lat, lon)
        case "Москва": presentMap?(55.7529517, 37.6232801)
        case "Санкт-Петербург": presentMap?(59.9396340, 30.3104843)
        default:
            break
        }
        
    }
    
    // MARK: - Helper functions
    
    private func setupUI() {
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.backgroundColor = .white
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 220),
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
        moveToChoosenCityButton.backgroundColor = .systemGreen
        moveToChoosenCityButton.addTarget(self, action: #selector(moveToMapViewHandle), for: .touchUpInside)
        moveToChoosenCityButton.layer.cornerRadius = 8
        moveToChoosenCityButton.standartShadow(view: moveToChoosenCityButton)
        
        self.backgroundColor = .clear
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
                                       paddingBottom: 8,
                                       paddingRight: 8,
                                       width: 32, height: 32)
    }
    
    func conigureCell(title: String, image: UIImage) {
        cellImage = image
        cellTitle = title
        cellNumberOfSight = 15
    }
    
}
