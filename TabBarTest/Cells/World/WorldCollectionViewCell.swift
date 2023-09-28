//
//  WorldCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol WorldCollectionViewCellDelegate: AnyObject {
    func showOnMap(country: String)
    func showSelectedCityDescription(_ name: String)
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
    
    let showCoutryOnMapButton = FilterView(withName: Constants.Views.look)
    
    let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    
    // MARK: - Public properties
    
    weak var delegate: WorldCollectionViewCellDelegate?
    static let identifier = "WorldCollectionViewCell"
    
    
    // MARK: - Private properties
    
    private var available: Bool = true
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
//        countryNameLabel.text = nil
//        subTitleLabel.text = nil
//        countyIconImageView.image = nil
//        modelCities = []
//        [countryNameLabel, subTitleLabel, countyIconImageView].forEach {
//            $0.alpha = 1
//        }
//        available = true
//        modelCities = []
//        collectionView.dataSource = nil
//        collectionView.delegate = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Helper functions
    
    func configureHeaderCell(header: WorldViewModels.TitleSection, cities: [WorldViewModels.ItemData]) {
        modelHeader = header
        modelCities = cities
        countryNameLabel.text = modelHeader.name
        subTitleLabel.text = modelHeader.subName
        countyIconImageView.image = modelHeader.iconCountry
        self.available = modelHeader.available
        let alphaValue = 0.65
        if !available {
            [countryNameLabel, subTitleLabel, countyIconImageView, showCoutryOnMapButton].forEach {
                $0.alpha = alphaValue
            }
            showCoutryOnMapButton.isUserInteractionEnabled = false
        }
        
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 280, height: 260)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        let tapShowMap = UITapGestureRecognizer(target: self, action: #selector(showCountryOnMapTapped))
        showCoutryOnMapButton.addGestureRecognizer(tapShowMap)
        
        collectionView.register(CountryCellsCitiesCollectionViewCell.self,
                                forCellWithReuseIdentifier: CountryCellsCitiesCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        contentView.addSubviews(countryNameLabel, countyIconImageView, subTitleLabel, showCoutryOnMapButton, collectionView)
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
        collectionView.anchor(top: subTitleLabel.bottomAnchor,
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
        delegate?.showOnMap(country: modelHeader.name)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension WorldCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource,
                                   UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelCities.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCellsCitiesCollectionViewCell.identifier, for: indexPath) as? CountryCellsCitiesCollectionViewCell else { return UICollectionViewCell() }
        let model = modelCities[indexPath.row]
        cell.conigureCell(title: model.name,
                          image: model.imageCity,
                          numberOfSight: model.sights,
                          available: available,
                          worldScreen: .country)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - CountryCellsCitiesCollectionViewCellDelegate

extension WorldCollectionViewCell: CountryCellsCitiesCollectionViewCellDelegate {
    // Открытие другого города
    func handleMap(name: String) {
        delegate?.showSelectedCityDescription(name)
    }
    
    // Открытие другого города на карте
    func handleSelectedCity(_ lat: Double, _ lon: Double) {
//        delegate?.showSelectedCityOnMap(lat, lon)
        print("Открытие другого города на карте")
    }
}
