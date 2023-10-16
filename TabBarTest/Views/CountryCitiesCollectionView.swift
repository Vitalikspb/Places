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
    weak var delegate: CountryCitiesCollectionViewDelegate?
    
    // MARK: - Private propertiesx
    
    private var model: [SightDescription] = []
    private var availabel: Bool = false
    
    
    
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
    
    public func configureCells(availabel: Bool, model: [SightDescription]) {
        self.model = model
        self.availabel = availabel
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension CountryCitiesCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(WorldCityCollectionViewCell.self, for: indexPath)
        let modelCell = model[indexPath.row]
        cell.configureCell(withName: modelCell.name,
                           sight: modelCell.sight_count,
                           andImage: modelCell.images[0],
                           alpha: availabel ? 1 : 0.65,
                           available: availabel)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
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


