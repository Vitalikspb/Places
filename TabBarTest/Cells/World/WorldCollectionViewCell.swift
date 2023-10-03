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
        imageView.contentMode = .center
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
    private let collectionViewCells: CountryCitiesCollectionView = {
       let view = CountryCitiesCollectionView()
        return view
        
    }()
    
    // MARK: - Public properties
    
    weak var delegate: WorldCollectionViewCellDelegate?
    static let identifier = "WorldCollectionViewCell"
    
    
    // MARK: - Private properties
    
    private var modelHeader: WorldViewModels.TitleSection!
    private var modelCities: [WorldViewModels.ItemData] = []
    
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
    
    func configureHeaderCell(header: WorldViewModels.TitleSection, cities: [WorldViewModels.ItemData], alpha: CGFloat, available: Bool) {
        modelHeader = header
        modelCities = cities
        
        countryNameLabel.text = modelHeader.name
        subTitleLabel.text = modelHeader.subName
        countyIconImageView.image = modelHeader.iconCountry
        [countryNameLabel, subTitleLabel, countyIconImageView, showCoutryOnMapButton].forEach {
            $0.alpha = alpha
        }
        collectionViewCells.configureCells(model: cities)
        collectionViewCells.delegate = self
        showCoutryOnMapButton.isUserInteractionEnabled = available
    }
    

    
    private func setupUI() {
        let tapShowMap = UITapGestureRecognizer(target: self, action: #selector(showCountryOnMapTapped))
        showCoutryOnMapButton.addGestureRecognizer(tapShowMap)
        
        contentView.addSubviews(countryNameLabel, countyIconImageView, subTitleLabel, showCoutryOnMapButton, collectionViewCells)

        countryNameLabel.anchor(top: contentView.topAnchor,
                                left: contentView.leftAnchor,
                                bottom: nil,
                                right: nil,
                                paddingTop: 12,
                                paddingLeft: 16,
                                paddingBottom: 0,
                                paddingRight: 0,
                                width: 0,
                                height: 32)
        countyIconImageView.anchor(top: contentView.topAnchor,
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
                             left: contentView.leftAnchor,
                             bottom: nil,
                             right: contentView.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 16,
                             paddingBottom: 0,
                             paddingRight: 16,
                             width: 0,
                             height: 20)
        showCoutryOnMapButton.anchor(top: contentView.topAnchor,
                                     left: nil,
                                     bottom: nil,
                                     right: contentView.rightAnchor,
                                     paddingTop: 20,
                                     paddingLeft: 0,
                                     paddingBottom: 0,
                                     paddingRight: 16,
                                     width: 108,
                                     height: 35)
        collectionViewCells.anchor(top: subTitleLabel.bottomAnchor,
                          left: contentView.leftAnchor,
                          bottom: contentView.bottomAnchor,
                          right: contentView.rightAnchor,
                          paddingTop: 8,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0,
                          height: 0)
    }
    
    // MARK: - Selectors
    
    @objc private func showCountryOnMapTapped() {
        delegate?.showOnMap(name: modelHeader.name)
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
