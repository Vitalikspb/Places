//
//  CountryCitiesCollectionView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 03.10.2023.
//

import UIKit

protocol CountryCitiesCollectionViewDelegate: AnyObject {
    func openCityOnMap(name: String)
    func showCity(name: String)
}

class CountryCitiesCollectionView: UIView {
   
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
        
        collectionView.register(WorldCityCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Public properties
    
    private var model: [WorldViewModels.ItemData] = []
    weak var delegate: CountryCitiesCollectionViewDelegate?
    
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
    
    public func configureCells(model: [WorldViewModels.ItemData]) {
        self.model = model
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension CountryCitiesCollectionView: UICollectionViewDataSource, UICollectionViewDelegate  {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(WorldCityCollectionViewCell.self, for: indexPath)
        let modelCell = model[indexPath.row]
        cell.configureCell(withName: modelCell.name,
                           sight: modelCell.sights,
                           andImage: modelCell.imageCity,
                           alpha: modelCell.available ? 1 : 0.65,
                           available: modelCell.available)
        cell.delegate = self
        return cell
    }
}

// MARK: - WorldCityCollectionViewCellDelegate

extension CountryCitiesCollectionView: WorldCityCollectionViewCellDelegate {
    
     // переход на город подробней
    func selectCity(name: String) {
        delegate?.showCity(name: name)
    }

    // переход на город на карте
    func showCityOnMap(name: String) {
        delegate?.openCityOnMap(name: name)
    }
}


