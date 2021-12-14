//
//  CountryPhotosTableViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol InterestingEventsTableViewCellDelegate: AnyObject {
    func showMoreText()
    func heightCell(height: CGFloat)
}

class InterestingEventsTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
        return label
    }()
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
        return label
    }()
    let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    private let mainTextLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = ""
        return label
    }()
    let gradientView = GradientView()
    let moreButtons: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "GillSans-semibold", size: 16)
        button.setTitle(Constants.Cells.readMore, for: .normal)
        return button
    }()
    
    // MARK: - Public properties
    
    weak var delegate: InterestingEventsTableViewCellDelegate?
    static let identifier = "InterestingEventsTableViewCell"
    private let layout = UICollectionViewFlowLayout()
    
    // MARK: - Public properties
    
    private lazy var modelImage = [UIImage]()
    
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
        gradientView.colors = [UIColor(white: 1, alpha: 0), UIColor.white]
        gradientView.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        layout.scrollDirection = .horizontal
        collectionView.register(InterestingEventsCollectionViewCell.self,
                                forCellWithReuseIdentifier: InterestingEventsCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        layout.itemSize = CGSize(width: 240, height: 170)
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        moreButtons.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(mainTextLabel)
        contentView.addSubview(gradientView)
        contentView.addSubview(moreButtons)
        contentView.addSubview(dateLabel)
        
        titleLabel.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: nil,
                          right: nil,
                          paddingTop: 8,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0,
                          height: 0)
        dateLabel.anchor(top: contentView.topAnchor,
                          left: titleLabel.rightAnchor,
                          bottom: nil,
                          right: contentView.rightAnchor,
                          paddingTop: 8,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 0,
                          height: 0)
        collectionView.anchor(top: titleLabel.bottomAnchor,
                              left: contentView.leftAnchor,
                              bottom: nil,
                              right: contentView.rightAnchor,
                              paddingTop: 8,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0,
                              height: 0)
        mainTextLabel.anchor(top: collectionView.bottomAnchor,
                             left: contentView.leftAnchor,
                             bottom: contentView.bottomAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 10,
                             paddingLeft: 16,
                             paddingBottom: 0,
                             paddingRight: 16,
                             width: 0, height: 0)
        gradientView.anchor(top: nil,
                            left: contentView.leftAnchor,
                            bottom: contentView.bottomAnchor,
                            right: contentView.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0, height: 50)
        moreButtons.anchor(top: nil,
                           left: contentView.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor,
                           paddingTop: 0,
                           paddingLeft: 16,
                           paddingBottom: 0,
                           paddingRight: 16,
                           width: 0, height: 35)
    }
    
    @objc func moreButtonTapped() {
        delegate?.showMoreText()
    }
    
    func configureCell(title: String, description: String, date: String, image: [UIImage]) {
        mainTextLabel.text = description
        titleLabel.text = title
        dateLabel.text = date
        modelImage = image
        
        let screenInsetsLeftRight: CGFloat = 32
        delegate?.heightCell(height: description.height(widthScreen: UIScreen.main.bounds.width - screenInsetsLeftRight,font: UIFont(name: "GillSans", size: 14)!))
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension InterestingEventsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestingEventsCollectionViewCell.identifier, for: indexPath) as? InterestingEventsCollectionViewCell else { return UICollectionViewCell() }
        cell.conigureCell(image: modelImage[indexPath.row])
        return cell
    }
    
    // Отступы от краев экрана на крайних ячейках
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    // Расстояние между ячейками - белый отступ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
