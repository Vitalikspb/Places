//
//  MustSeeTableViewCell.swift
//  TabBarTest
//
//

import UIKit

class ChoiseRedactionTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
        label.text = "Выбор редакции"
        return label
    }()
    let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    
    // MARK: - Public properties
    static let identifier = "ChoiseRedactionTableViewCell"
    
    // MARK: - Private properties
    struct MustSeeStruct {
        let name: String
        let image: UIImage
    }
    private var mustSeeArray: [MustSeeStruct] = [
        MustSeeStruct(name: "Эрмитаж", image: UIImage(named: "hub3")!),
        MustSeeStruct(name: "Русский музей", image: UIImage(named: "hub3")!),
        MustSeeStruct(name: "Купчино", image: UIImage(named: "hub3")!),
        MustSeeStruct(name: "Петропавловская крепость", image: UIImage(named: "hub3")!),
        MustSeeStruct(name: "Казанский собор", image: UIImage(named: "hub3")!),
        MustSeeStruct(name: "Исаакиевский собор", image: UIImage(named: "hub3")!)
    ]
    
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
        layout.itemSize = CGSize(width: 230, height: 170)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        collectionView.register(ChoiseRedactionCellsCitiesCollectionViewCell.self,
                                forCellWithReuseIdentifier: ChoiseRedactionCellsCitiesCollectionViewCell.identifier)
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

extension ChoiseRedactionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mustSeeArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChoiseRedactionCellsCitiesCollectionViewCell.identifier, for: indexPath) as? ChoiseRedactionCellsCitiesCollectionViewCell else { return UICollectionViewCell() }
        cell.conigureCell(name: mustSeeArray[indexPath.row].name,
                          image: mustSeeArray[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
