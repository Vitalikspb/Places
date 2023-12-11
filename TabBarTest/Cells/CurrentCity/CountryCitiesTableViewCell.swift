//
//  CountryCitiesTableViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol CountryCitiesTableViewCellDelegate: AnyObject {
    func showSelectedCityOnMap(_ lat: Double, _ lon: Double)
    func showSelectedCityDescription(_ name: String)
}

class CountryCitiesTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .bold, andSize: 28)
        label.text = "Другие города"
        return label
    }()
    let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    
    // MARK: - Public properties
    
    weak var delegate: CountryCitiesTableViewCellDelegate?
    static let identifier = "CountryCitiesTableViewCell"
    private var model: [SightDescriptionResponce] = []
    
    // MARK: - Private properties
    
    
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
    
    func configCell(model: [SightDescriptionResponce]) {
        self.model = model
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 280, height: 260)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        collectionView.register(CountryCellsCitiesCollectionViewCell.self,
                                forCellWithReuseIdentifier: CountryCellsCitiesCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        
        titleLabel.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: nil,
                          right: contentView.rightAnchor,
                          paddingTop: 8,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 8,
                          width: 0,
                          height: 32)
        collectionView.anchor(top: titleLabel.bottomAnchor,
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
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension CountryCitiesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCellsCitiesCollectionViewCell.identifier, for: indexPath) as? CountryCellsCitiesCollectionViewCell else { return UICollectionViewCell() }
        let data = model[indexPath.row]
        let model = CountryCellCitiesModel(title: data.name,
                                           image: UIImage(named: data.images.first!) ?? UIImage(),
                                           numberOfSight: data.sight_count,
                                           latitude: data.latitude,
                                           longitude: data.longitude,
                                           available: true,
                                           worldScreen: .cities)
        cell.conigureCell(model: model)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - CountryCellsCitiesCollectionViewCellDelegate

extension CountryCitiesTableViewCell: CountryCellsCitiesCollectionViewCellDelegate {
    // Открытие другого города
    func handleMap(name: String) {
        delegate?.showSelectedCityDescription(name)
    }
    
    // Открытие другого города на карте
    func handleSelectedCity(_ lat: Double, _ lon: Double) {
        delegate?.showSelectedCityOnMap(lat, lon)
    }
}
