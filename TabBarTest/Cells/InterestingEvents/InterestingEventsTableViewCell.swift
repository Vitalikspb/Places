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
    var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.isUserInteractionEnabled = false
        return control
    }()
    private let mainTextLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = ""
        return label
    }()
    private let gradientView = GradientView()
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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.register(CountryCellsPhotosCollectionViewCell.self,
                                forCellWithReuseIdentifier: CountryCellsPhotosCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.isPagingEnabled = true
        
        gradientView.colors = [UIColor(white: 1, alpha: 0), UIColor.white]
        gradientView.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        moreButtons.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        contentView.addSubview(mainTextLabel)
        contentView.addSubview(gradientView)
        contentView.addSubview(dateLabel)
        
        titleLabel.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: nil,
                          right: nil,
                          paddingTop: 0,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0,
                          height: 0)
        dateLabel.anchor(top: contentView.topAnchor,
                          left: titleLabel.rightAnchor,
                          bottom: nil,
                          right: contentView.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 0,
                          height: 0)
        collectionView.anchor(top: titleLabel.bottomAnchor,
                              left: contentView.leftAnchor,
                              bottom: nil,
                              right: contentView.rightAnchor,
                              paddingTop: 16,
                              paddingLeft: 16,
                              paddingBottom: 0,
                              paddingRight: 16,
                              width: 0,
                              height: 200)
        pageControl.anchor(top: nil,
                           left: contentView.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor,
                           paddingTop: 0,
                           paddingLeft: 50,
                           paddingBottom: 20,
                           paddingRight: 50,
                           width: 0,
                           height: 0)
        mainTextLabel.anchor(top: collectionView.bottomAnchor,
                             left: contentView.leftAnchor,
                             bottom: nil,
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
                            paddingLeft: 16,
                            paddingBottom: 0,
                            paddingRight: 16,
                            width: 0, height: 70)
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
        modelImage = image
        dateLabel.text = date
        let screenInsetsLeftRight:CGFloat = 32
        
        delegate?.heightCell(height: description.height(widthScreen: UIScreen.main.bounds.width - screenInsetsLeftRight,font: UIFont(name: "GillSans", size: 14)!))
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension InterestingEventsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = 5
        pageControl.numberOfPages = count
        pageControl.isHidden = !(count > 1)
        return count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCellsPhotosCollectionViewCell.identifier, for: indexPath) as? CountryCellsPhotosCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(data: modelImage[indexPath.row])
        cell.layer.cornerRadius = 10
        return cell
    }
    
    // Отступы от краев экрана на крайних ячейках
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    // Размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-32,
                      height: UIScreen.main.bounds.width-(UIScreen.main.bounds.width/3))
    }
    
    // Расстояние между ячейками - белый отступ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
