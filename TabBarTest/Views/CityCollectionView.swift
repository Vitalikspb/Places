//
//  CityCollectionView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 03.10.2023.
//

import UIKit

protocol CityCollectionViewDelegate: AnyObject {
    func openCityOnMap(name: String)
    func favoriteTapped(name: String)
}

class CityCollectionView: UIView {
    
    // MARK: - UI properties
    
    private var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 230, height: 180)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SightCollectionViewCell.self,
                                forCellWithReuseIdentifier: SightCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Public properties
    
    weak var delegate: CityCollectionViewDelegate?
    
    // MARK: - Private propertiesx
    
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

extension CityCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(SightCollectionViewCell.self, for: indexPath)
        let modelCell = model[indexPath.row]
        cell.conigureCell(name: modelCell.name,
                          image: UIImage(named: modelCell.big_image) ?? UIImage(),
                          favotite: UIImage(named: modelCell.favorite) ?? UIImage())
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.openCityOnMap(name: model[indexPath.row].name)
    }
}

// MARK: - SightCollectionViewCellDelegate

extension CityCollectionView: SightCollectionViewCellDelegate {
    
    func favoritesTapped(name: String) {
        delegate?.favoriteTapped(name: name)
    }
    
    
}
