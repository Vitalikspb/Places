//
//  MustSeeTableViewCell.swift
//  TabBarTest
//
//

import UIKit

class TicketCollectionViewCell: UITableViewCell {
    
    // MARK: - UI properties
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
        label.text = Constants.Cells.ticketToSights
        return label
    }()
    let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    
    // MARK: - Public properties
    static let identifier = "TicketCollectionViewCell"
    
    // MARK: - Private properties
    var model: [GuideSightsModel] = []
    
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
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 250, height: 180)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        collectionView.register(TicketsCellsCitiesCollectionViewCell.self,
                                forCellWithReuseIdentifier: TicketsCellsCitiesCollectionViewCell.identifier)
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

extension TicketCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketsCellsCitiesCollectionViewCell.identifier, for: indexPath) as? TicketsCellsCitiesCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(title: model[indexPath.row].name,
                          image: model[indexPath.row].image,
                          price: model[indexPath.row].price,
                          rating: model[indexPath.row].rating,
                          reviews: model[indexPath.row].reviews)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
