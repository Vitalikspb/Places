//
//  MustSeeTableViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol SightTableViewCellDelegate: AnyObject {
    func handleSelectedSight(_ name: String)
}

class SightTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .bold, andSize: 20)
        label.text = Constants.Cells.mustSeeSights
        return label
    }()
    let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    
    // MARK: - Public properties
    
    static let identifier = "SightTableViewCell"
    weak var delegate: SightTableViewCellDelegate?
    
    // MARK: - Private properties
    
    private var sizeCell = CGSize(width: 200, height: 140) {
        didSet {
            layout.itemSize = CGSize(width: sizeCell.width, height: sizeCell.height)
        }
    }
    private var model: [SightsModel] = []
    
    // MARK: - Private properties
    
    private let layout = UICollectionViewFlowLayout()

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
    
    func configureCell(model: [SightsModel], title: String, size: CGSize) {
        self.model = model
        titleLabel.text = title
        sizeCell = size
    }
    
    private func setupUI() {
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        collectionView.register(SightCollectionViewCell.self,
                                forCellWithReuseIdentifier: SightCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.setCollectionViewLayout(layout, animated: true)
        contentView.addSubviews(titleLabel, collectionView)

        titleLabel.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: nil,
                          right: contentView.rightAnchor,
                          paddingTop: 8,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 8,
                          width: 0,
                          height: 32)

        collectionView.anchor(top: titleLabel.bottomAnchor,
                          left: contentView.leftAnchor,
                          bottom: contentView.bottomAnchor,
                          right: contentView.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0,
                          height: 0)
    }
    
    @objc private func moveToMapViewHandle(name: String) {
        delegate?.handleSelectedSight(name)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension SightTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SightCollectionViewCell.identifier, for: indexPath) as? SightCollectionViewCell else { return UICollectionViewCell() }
        cell.conigureCell(name: model[indexPath.row].name,
                          image: UIImage(named: model[indexPath.row].image) ?? UIImage())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            moveToMapViewHandle(name: model[indexPath.row].name)
    }
}


