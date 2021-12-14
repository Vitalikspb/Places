//
//  MainFloatingView.swift
//  TabBarTest
//
//

import UIKit

class FavouritesTopView: UIView {
    
    // MARK: - Public properties
    
    var dataModel = [IFavouritesAllCitiesModel]()
    weak var delegate: FavouritesTableViewCellDelegate?
    
    // MARK: - UI properties
    
    let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper functions
    
    func setupModel(model: [IFavouritesAllCitiesModel]) {
        dataModel = model
    }
    
    private func configureUI() {
        self.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 220, height: 160)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        layout.scrollDirection = .horizontal
        collectionView.register(FavouritesTopCollectionViewCell.self,
                                forCellWithReuseIdentifier: FavouritesTopCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        addSubview(collectionView)
        
        collectionView.anchor(top: topAnchor,
                              left: leftAnchor,
                              bottom: bottomAnchor,
                              right: rightAnchor,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0,
                              height: 0)
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension FavouritesTopView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouritesTopCollectionViewCell.identifier, for: indexPath) as? FavouritesTopCollectionViewCell else { return UICollectionViewCell() }
        //        cell.layer.cornerRadius = 10
        cell.conigureCell(city: dataModel[indexPath.row].city,
                          name: dataModel[indexPath.row].nameOfSight,
                          image: dataModel[indexPath.row].image,
                          favouritesFlag: dataModel[indexPath.row].sightFavouritesFlag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showSelectedSightOnMap(dataModel[indexPath.row].nameOfSight)
    }
    
    // Отступы от краев экрана на крайних ячейках
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    // Расстояние между ячейками - белый отступ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
