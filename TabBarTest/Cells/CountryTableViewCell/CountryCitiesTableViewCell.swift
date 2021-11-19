//
//  CountryCitiesTableViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol CountryCitiesTableViewCellDelegate: AnyObject {
    func showSelectedCityOnMap(_ lat: Double, _ lon: Double)
}

class CountryCitiesTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    
    let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    
    // MARK: - Public properties
    weak var delegate: CountryCitiesTableViewCellDelegate?
    static let identifier = "CountryCitiesTableViewCell"
    
    // MARK: - Private properties
    private var citiesAvailable = ["Москва","Санкт-Петербург","Сочи","Краснодар","Гатчина","Cupertino"]
    
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
    
    func configCell(title: String) {
        
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 280, height: 180)
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
        contentView.addSubview(collectionView)
        collectionView.addConstraintsToFillView(view: contentView)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension CountryCitiesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return citiesAvailable.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCellsCitiesCollectionViewCell.identifier, for: indexPath) as? CountryCellsCitiesCollectionViewCell else { return UICollectionViewCell() }
        
        cell.conigureCell(title: citiesAvailable[indexPath.row], image: UIImage(named: "hub3")!)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension CountryCitiesTableViewCell: CountryCellsCitiesCollectionViewCellDelegate {
    func handleSelectedCity(_ lat: Double, _ lon: Double) {
        delegate?.showSelectedCityOnMap(lat, lon)
    }
}
