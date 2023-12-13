//
//  FloatingViewSecondTableViewCell.swift
//  TabBarTest
//
//

import UIKit

class FloatingViewSecondTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    
    private let collectionView = UICollectionView(frame: CGRect.zero,
                                                  collectionViewLayout: UICollectionViewLayout.init())
    
    // MARK: - Public properties
    
    static let identifier = "FloatingViewSecondTableViewCell"
    
    // MARK: - Private properties
    
    private var model: [String] = []
    
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
    
    func configCell(model: [String]) {
        self.model = model
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 256, height: 184)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        collectionView.register(FloatingCollectionViewCell.self,
                                forCellWithReuseIdentifier: FloatingCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        collectionView.setCollectionViewLayout(layout, animated: true)
        contentView.addSubview(collectionView)
        collectionView.addConstraintsToFillView(view: contentView)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension FloatingViewSecondTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FloatingCollectionViewCell.identifier, 
                                                            for: indexPath) as? FloatingCollectionViewCell else { return UICollectionViewCell() }
        NetworkHelper.shared.downloadImage(from: model[indexPath.row]) { image in
            cell.configureCell(imageName: image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
