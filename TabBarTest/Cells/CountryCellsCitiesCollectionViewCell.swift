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
        label.textColor = .setCustomColor(color: .titleText)
        label.contentMode = .bottom
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans-semiBold", size: 16)
        return label
    }()
    private let numberOfSightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.init(name: "GillSans", size: 14)
        return label
    }()
    
    private let moveToChoosenCityView: UIView = {
        let view = UIView()
        view.backgroundColor = .setCustomColor(color: .mainView)
        view.layer.cornerRadius = 6
        return view
    }()
    private let moveToChoosenCityButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = .setCustomColor(color: .titleText)
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "moveToMap")
        return imageView
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
    
    // MARK: - Helper functions
    
    private func setupUI() {
        let moveTap = UIGestureRecognizer(target: self, action: #selector(moveToMapViewHandle))
        moveToChoosenCityButton.isUserInteractionEnabled = true
        moveToChoosenCityButton.addGestureRecognizer(moveTap)
        
        self.backgroundColor = .clear
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        contentView.addSubviews(image, title, numberOfSightLabel, moveToChoosenCityView)
        moveToChoosenCityView.addSubviews(moveToChoosenCityButton)
    }
    
    private func setupConstraints() {
        image.anchor(top: contentView.topAnchor,
                     left: contentView.leftAnchor,
                     bottom: title.topAnchor,
                     right: contentView.rightAnchor,
                     paddingTop: 0,
                     paddingLeft: 0,
                     paddingBottom: 4,
                     paddingRight: 0,
                     width: 0, height: 0)
        
        title.anchor(top: nil,
                     left: contentView.leftAnchor,
                     bottom: nil,
                     right: moveToChoosenCityButton.leftAnchor,
                     paddingTop: 0,
                     paddingLeft: 0,
                     paddingBottom: 0,
                     paddingRight: 0,
                     width: 0, height: 25)
        numberOfSightLabel.anchor(top: title.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  bottom: contentView.bottomAnchor,
                                  right: nil,
                                  paddingTop: 0,
                                  paddingLeft: 0,
                                  paddingBottom: 8,
                                  paddingRight: 0,
                                  width: 0, height: 20)
        moveToChoosenCityView.anchor(top: image.topAnchor,
                                     left: nil,
                                     bottom: nil,
                                     right: image.rightAnchor,
                                     paddingTop: 8,
                                     paddingLeft: 0,
                                     paddingBottom: 0,
                                     paddingRight: 8,
                                     width: 35, height: 35)
        moveToChoosenCityButton.addConstraintsToFillView(view: moveToChoosenCityView)
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

