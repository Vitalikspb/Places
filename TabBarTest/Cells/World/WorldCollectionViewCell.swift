//
//  WorldCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol WorldCollectionViewCellDelegate: AnyObject {
    func showOnMap(name: String)
    func showSelectedCityDescription(name: String)
}

class WorldCollectionViewCell: UITableViewCell {
    
    // MARK: - UI properties
    private let headerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        return view
    }()
    private let countryNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .bold, andSize: 20)
        return label
    }()
    private let countyIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .regular, andSize: 16)
        return label
    }()
    private let showCoutryOnMapButton = FilterView(withName: Constants.Views.look)
    private let animateButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
        return button
    }()
    private let collectionViewCells: CountryCitiesCollectionView = {
        let view = CountryCitiesCollectionView()
        return view
        
    }()
    
    // MARK: - Public properties
    
    weak var delegate: WorldCollectionViewCellDelegate?
    static let identifier = "WorldCollectionViewCell"
    
    
    // MARK: - Private properties
    
    private var modelHeader: WorldViewModels.TitleSection!
    private var modelCities: [SightDescription] = []
    
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
        countryNameLabel.text = ""
        subTitleLabel.text = ""
        countyIconImageView.image = UIImage()
        [countryNameLabel, subTitleLabel, countyIconImageView].forEach {
            $0.alpha = 1
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Helper functions
    
    func configureHeaderCell(header: WorldViewModels.TitleSection, cities: [SightDescription], alpha: CGFloat, available: Bool) {
        modelHeader = header
        modelCities = cities
        
        countryNameLabel.text = header.country
        subTitleLabel.text = header.subTitle
        countyIconImageView.image = UIImage(named: header.iconName)
        
        [countryNameLabel, subTitleLabel, countyIconImageView, showCoutryOnMapButton].forEach {
            $0.alpha = alpha
        }
        collectionViewCells.configureCells(availabel: header.available, model: cities)
        collectionViewCells.delegate = self
        showCoutryOnMapButton.isUserInteractionEnabled = available
        animateButton.isUserInteractionEnabled = available
    }
    
    private func setupUI() {
        animateButton.delegate = self

        contentView.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        contentView.addSubviews(headerView, animateButton, collectionViewCells)
        animateButton.addSubviews(showCoutryOnMapButton)
        
        headerView.addSubviews(countryNameLabel, countyIconImageView, subTitleLabel)
        
        headerView.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: nil,
                          right: contentView.rightAnchor,
                          paddingTop: 12,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 0,
                          height: 74)
        
        animateButton.centerY(inView: headerView)
        animateButton.anchor(top: nil,
                                     left: nil,
                                     bottom: nil,
                                     right: headerView.rightAnchor,
                                     paddingTop: 0,
                                     paddingLeft: 0,
                                     paddingBottom: 0,
                                     paddingRight: 16,
                                     width: 108,
                                     height: 35)
        showCoutryOnMapButton.addConstraintsToFillView(view: animateButton)
        
        collectionViewCells.anchor(top: headerView.bottomAnchor,
                                   left: contentView.leftAnchor,
                                   bottom: contentView.bottomAnchor,
                                   right: contentView.rightAnchor,
                                   paddingTop: 8,
                                   paddingLeft: 0,
                                   paddingBottom: 0,
                                   paddingRight: 0,
                                   width: 0,
                                   height: 0)
        
        countryNameLabel.anchor(top: headerView.topAnchor,
                                left: headerView.leftAnchor,
                                bottom: nil,
                                right: nil,
                                paddingTop: 12,
                                paddingLeft: 16,
                                paddingBottom: 0,
                                paddingRight: 0,
                                width: 0,
                                height: 32)
        countyIconImageView.anchor(top: headerView.topAnchor,
                                   left: countryNameLabel.rightAnchor,
                                   bottom: nil,
                                   right: nil,
                                   paddingTop: 16,
                                   paddingLeft: 8,
                                   paddingBottom: 0,
                                   paddingRight: 0,
                                   width: 24,
                                   height: 24)
        
        subTitleLabel.anchor(top: countryNameLabel.bottomAnchor,
                             left: headerView.leftAnchor,
                             bottom: headerView.bottomAnchor,
                             right: headerView.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 16,
                             paddingBottom: 10,
                             paddingRight: 16,
                             width: 0,
                             height: 20)
        
    }
}

// MARK: - CountryCitiesCollectionViewDelegate

extension WorldCollectionViewCell: CountryCitiesCollectionViewDelegate {
    
    // переход на город подробней
    func openCityOnMap(name: String) {
        delegate?.showOnMap(name: name)
    }
    
    // переход на город подробней
    func showCity(name: String) {
        delegate?.showSelectedCityDescription(name: name)
    }
    
}

// MARK: - CustomAnimatedButtonDelegate

extension WorldCollectionViewCell: CustomAnimatedButtonDelegate {
    
    func continueButton(model: ButtonCallBackModel) {
        print("showCountryOnMapTapped: \(modelHeader.country)")
        delegate?.showOnMap(name: modelHeader.country)
    }
    
}
