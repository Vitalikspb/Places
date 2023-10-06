//
//  FavouritesTableViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol FavouritesTableViewCellDelegate: AnyObject {
    func tapFavouriteButton()
    func showCity(name: String)
}

// Класс ячейки для основной таблицы достопримечательностей
class FavouritesTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    
    private let backgroundCityView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        return view
    }()
    
    private let cityLabel: UILabel = {
       let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 20)
        label.text = "Москва"
        return label
    }()
    
    private let collectionViewCells: FavouritesCitiesCollectionView = {
       let view = FavouritesCitiesCollectionView()
        return view
    }()
    
    
    
    // MARK: - Public properties
    
    var dataModel: [FavouritesViewModel.ItemData]!
    weak var delegate: FavouritesTableViewCellDelegate?
    static let identifier = "FavouritesTableViewCell"
    
    
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
    
    func configCell(city: String, data: [FavouritesViewModel.ItemData]) {
        dataModel = data
        cityLabel.text = city
        
        collectionViewCells.configureCells(model: dataModel)
    }
    
    private func setupUI() {
        collectionViewCells.delegate = self
        
        contentView.addSubviews(backgroundCityView, collectionViewCells)
        backgroundCityView.addSubviews(cityLabel)
        
        cityLabel.anchor(top: nil,
                         left: backgroundCityView.leftAnchor,
                         bottom: nil,
                         right: backgroundCityView.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 16,
                         paddingBottom: 0,
                         paddingRight: 16,
                         width: 0,
                         height: 0)
        cityLabel.centerY(inView: backgroundCityView)
        
        backgroundCityView.anchor(top: contentView.topAnchor,
                                  left: contentView.leftAnchor,
                                  bottom: nil,
                                  right: contentView.rightAnchor,
                                  paddingTop: 8,
                                  paddingLeft: 16,
                                  paddingBottom: 0,
                                  paddingRight: 8,
                                  width: 0,
                                  height: 50)
        
        collectionViewCells.anchor(top: backgroundCityView.bottomAnchor,
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

// MARK: - FavouritesCitiesCollectionViewDelegate

extension FavouritesTableViewCell: FavouritesCitiesCollectionViewDelegate {
    
    // Нажатие на кнопку избранное в ячейке
    func tapFavouriteButton() {
        delegate?.tapFavouriteButton()
    }
    
    // Открытие города подробней
    func showCity(name: String) {
        delegate?.showCity(name: name)
    }
}
