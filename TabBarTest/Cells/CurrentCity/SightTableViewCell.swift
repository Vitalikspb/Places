//
//  MustSeeTableViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol SightTableViewCellDelegate: AnyObject {
    func handleSelectedSight(_ name: String)
    func lookAll()
}

class SightTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-bold", size: 20)
        label.text = Constants.Cells.mustSeeSights
        return label
    }()
    private let lookAllLabel: UILabel = {
       let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .right
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
        label.text = Constants.Cells.lookAll
        return label
    }()
    let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    
    // MARK: - Public properties
    
    var model: [SightsModel] = []
    static let identifier = "SightTableViewCell"
    weak var delegate: SightTableViewCellDelegate?
    var titleCell: String = "" {
        didSet {
            titleLabel.text = titleCell
        }
    }
    var sizeCell = CGSize(width: 200, height: 140) {
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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Helper functions
    
    private func setupUI() {
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        let tapLookAll = UITapGestureRecognizer(target: self, action: #selector(lookAllTapped))
        lookAllLabel.isUserInteractionEnabled = true
        lookAllLabel.addGestureRecognizer(tapLookAll)
        
        collectionView.register(SightCollectionViewCell.self,
                                forCellWithReuseIdentifier: SightCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.setCollectionViewLayout(layout, animated: true)
        contentView.addSubviews(titleLabel, collectionView, lookAllLabel)

        titleLabel.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: nil,
                          right: lookAllLabel.leftAnchor,
                          paddingTop: 8,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 8,
                          width: 0,
                          height: 32)
        lookAllLabel.anchor(top: contentView.topAnchor,
                          left: nil,
                          bottom: nil,
                          right: contentView.rightAnchor,
                          paddingTop: 8,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 85,
                          height: 35)
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
        switch name {
        case "Эрмитаж":       delegate?.handleSelectedSight(name)
        case "Русский музей": delegate?.handleSelectedSight(name)
        default:
            break
        }
    }
    
    @objc private func lookAllTapped() {
        delegate?.lookAll()
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
                          image: model[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            moveToMapViewHandle(name: model[indexPath.row].name)
    }
}


