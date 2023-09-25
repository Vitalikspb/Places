//
//  FavouritesTableViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol FavouritesTableViewCellDelegate: AnyObject {
    func showSelectedSightOnMap(_ name: String)
}

// Класс ячейки для основной таблицы достопримечательностей
class FavouritesTableViewCell: UITableViewCell {
    
    struct CellModel {
        var city: String
        var descriptionCity: [CitySight]
    }
    struct CitySight {
        var sightType: String
        var sightName: String
        var sightImage: UIImage
        var sightFavouritesFlag: Bool
    }
    
    // MARK: - UI properties
    let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        label.text = "Москва"
        return label
    }()
    
    
    // MARK: - Public properties
    
    // MARK: - TODO изменить модель под своб собственную
    var dataModel: CellModel!
    
    weak var delegate: FavouritesTableViewCellDelegate?
    static let identifier = "FavouritesTableViewCell"
    
    // MARK: - Private properties
    // MARK: - TODO Изменить citiesAvailable на нормальные данные из модели
    private var citiesAvailable = ["Эрмитаж","Русский музей","Мавзолей","Красная площадь"]
    
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
    
    func configCell(data: CellModel) {
        dataModel = data
        titleLabel.text = dataModel.city
    }
    
    private func setupUI() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 280, height: 180)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        collectionView.register(FavouritesTableViewCollectionViewCell.self,
                                forCellWithReuseIdentifier: FavouritesTableViewCollectionViewCell.identifier)
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
                          height: 0)
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

extension FavouritesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.descriptionCity.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouritesTableViewCollectionViewCell.identifier, for: indexPath) as? FavouritesTableViewCollectionViewCell else { return UICollectionViewCell() }
        
        cell.conigureCell(title: dataModel.descriptionCity[indexPath.row].sightName,
                          type: dataModel.descriptionCity[indexPath.row].sightType,
                          image: dataModel.descriptionCity[indexPath.row].sightImage,
                          favouritesFlag: dataModel.descriptionCity[indexPath.row].sightFavouritesFlag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showSelectedSightOnMap(citiesAvailable[indexPath.row])
    }
}

