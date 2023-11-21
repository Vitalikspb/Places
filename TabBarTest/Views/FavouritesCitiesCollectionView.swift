//
//  FavouritesCitiesCollectionView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 03.10.2023.
//

import UIKit

protocol FavouritesCitiesCollectionViewDelegate: AnyObject {
    func tapFavouriteButton(name: String)
    func showCity(name: String)
}

class FavouritesCitiesCollectionView: UIView {
   
    // MARK: - UI properties
    
    private var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 260)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(FavouritesTableViewCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Public properties
    
    weak var delegate: FavouritesCitiesCollectionViewDelegate?
    static let identifier = "FavouritesCitiesCollectionView"
    
    // MARK: - Private properties
    private var model: [Sight] = []
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Helper functions
    
    private func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self

        addSubviews(containerView)
        containerView.addSubviews(collectionView)

        containerView.addConstraintsToFillView(view: self)
        collectionView.addConstraintsToFillView(view: containerView)
    }
    
    public func configureCells(model: [Sight]) {
        self.model = model
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension FavouritesCitiesCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(FavouritesTableViewCollectionViewCell.self, for: indexPath)
        let modelCell = model[indexPath.row]
        cell.configureCell(withName: modelCell.name,
                           typeSight: modelCell.type.rawValue,
                           andImage: UIImage(named: modelCell.big_image) ?? UIImage())
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - WorldCityCollectionViewCellDelegate

extension FavouritesCitiesCollectionView: FavouritesTableViewCollectionViewCellDelegate {
    
    // Нажатие на кнопку избранное в ячейке
    func tapFavouriteButton(name: String) {
        delegate?.tapFavouriteButton(name: name)
    }
    
    // Открытие города подробней
    func showCity(name: String) {
        delegate?.showCity(name: name)
    }
}


