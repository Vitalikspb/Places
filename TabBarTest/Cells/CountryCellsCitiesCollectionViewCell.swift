//
//  CountryCellsCitiesCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

enum WorldScreenOpen {
    case cities
    case country
}

struct CountryCellCitiesModel {
    var title: String
    var image: UIImage
    var numberOfSight: Int
    var latitude: Double
    var longitude: Double
    var available: Bool
    var worldScreen: WorldScreenOpen
}

protocol CountryCellsCitiesCollectionViewCellDelegate: AnyObject {
    func handleSelectedCity(_ lat : Double, _ lon: Double)
    func handleMap(name: String)
}

class CountryCellsCitiesCollectionViewCell: UICollectionViewCell {
    
    
    
    // MARK: - UI properties
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.contentMode = .bottom
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        return label
    }()
    private let numberOfSightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.contentMode = .center
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .regular, andSize: 14)
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
    
    private let favouriteButton: CustomAnimatedButton = {
        let button = CustomAnimatedButton()
        return button
    }()
    
    
    // MARK: - Public properties
    
    weak var delegate: CountryCellsCitiesCollectionViewCellDelegate?
    static let identifier = "CountryCellsCitiesCollectionViewCell"
    var cellImage: UIImage = UIImage() {
        didSet {
            mainImageView.image = cellImage
        }
    }
    var cellTitle: String = "" {
        didSet {
            titleLabel.text = cellTitle
        }
    }
    var cellNumberOfSight: Int = 0 {
        didSet {
            numberOfSightLabel.text = "\(Constants.Cells.countSights): \(cellNumberOfSight)"
        }
    }
    
    // MARK: - Private properties
    
    private var latitude = 59.88422
    private var longitude = 30.2545
    
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
        titleLabel.text = ""
        numberOfSightLabel.text = ""
        mainImageView.image = UIImage()
        titleLabel.alpha = 1
        numberOfSightLabel.alpha = 1
        mainImageView.alpha = 1
    }
    
    // MARK: - Helper functions
    
    private func setupUI() {
        favouriteButton.delegate = self
        let mapTap = UITapGestureRecognizer(target: self, action: #selector(moveToCityViewHandle))
        mainImageView.isUserInteractionEnabled = true
        mainImageView.addGestureRecognizer(mapTap)
        
        self.backgroundColor = .clear
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        contentView.addSubviews(mainImageView, titleLabel, numberOfSightLabel, favouriteButton)
        favouriteButton.addSubviews(moveToChoosenCityView)
        moveToChoosenCityView.addSubviews(moveToChoosenCityButton)
    }
    
    private func setupConstraints() {
        mainImageView.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             bottom: titleLabel.topAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 4,
                             paddingRight: 0,
                             width: 0, height: 0)
        
        titleLabel.anchor(top: nil,
                          left: contentView.leftAnchor,
                          bottom: nil,
                          right: moveToChoosenCityButton.leftAnchor,
                          paddingTop: 0,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0, height: 25)
        numberOfSightLabel.anchor(top: titleLabel.bottomAnchor,
                                  left: contentView.leftAnchor,
                                  bottom: contentView.bottomAnchor,
                                  right: nil,
                                  paddingTop: 0,
                                  paddingLeft: 0,
                                  paddingBottom: 8,
                                  paddingRight: 0,
                                  width: 0, height: 20)
        favouriteButton.anchor(top: mainImageView.topAnchor,
                               left: nil,
                               bottom: nil,
                               right: mainImageView.rightAnchor,
                               paddingTop: 8,
                               paddingLeft: 0,
                               paddingBottom: 0,
                               paddingRight: 8,
                               width: 35, height: 35)
        moveToChoosenCityView.addConstraintsToFillView(view: favouriteButton)
        moveToChoosenCityButton.addConstraintsToFillView(view: moveToChoosenCityView)
    }
    
    func conigureCell(model: CountryCellCitiesModel) {
        switch model.worldScreen {
            
        case .cities:
            break
            
        case .country:
            moveToChoosenCityView.isHidden = true
            moveToChoosenCityButton.isHidden = true
        }
        if !model.available {
            titleLabel.alpha = 0.65
            numberOfSightLabel.alpha = 0.65
            mainImageView.alpha = 0.65
        }
        
        cellImage = model.image
        cellTitle = model.title
        cellNumberOfSight = model.numberOfSight
        self.latitude = model.latitude
        self.longitude = model.longitude
    }
    
    // MARK: - Selectors
    @objc private func moveToCityViewHandle() {
        delegate?.handleMap(name: cellTitle)
    }
    
    @objc private func moveToMapViewHandle() {
        switch cellTitle {
        case "Москва":
            delegate?.handleSelectedCity(latitude, longitude)
            
        case "Санкт-Петербург":
            delegate?.handleSelectedCity(59.9396340, 30.3104843)
            
        default:
            break
        }
    }
}

// MARK: - CustomAnimatedButtonDelegate

extension CountryCellsCitiesCollectionViewCell: CustomAnimatedButtonDelegate {
    
    func continueButton(id: Int) {
        moveToMapViewHandle()
    }
}

