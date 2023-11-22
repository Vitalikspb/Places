//
//  MustSeeTableViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol SightTableViewCellDelegate: AnyObject {
    func handleSelectedSight(_ name: String)
    func favoritesTapped(name: String)
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
    
    private let collectionViewCells: CityCollectionView = {
        let view = CityCollectionView()
        return view
    }()
    
    // MARK: - Public properties
    
    static let identifier = "SightTableViewCell"
    weak var delegate: SightTableViewCellDelegate?
    
    // MARK: - Private properties
    
    private var sizeCell = CGSize(width: 200, height: 140) {
        didSet {
            layout.itemSize = CGSize(width: sizeCell.width, height: sizeCell.height)
        }
    }
    
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
        titleLabel.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Helper functions
    
    func configureCell(model: [Sight], title: String,  size: CGSize) {
        titleLabel.text = title
        sizeCell = size
        collectionViewCells.configureCells(model: model)
        collectionViewCells.delegate = self
    }
    
    private func setupUI() {
        contentView.addSubviews(titleLabel, collectionViewCells)

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

        collectionViewCells.anchor(top: titleLabel.bottomAnchor,
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


// MARK: - SightCollectionViewCellDelegate

extension SightTableViewCell: CityCollectionViewDelegate {
    
    func openCityOnMap(name: String) {
        delegate?.handleSelectedSight(name)
    }
    
    func favoriteTapped(name: String) {
        delegate?.favoritesTapped(name: name)
    }

}

