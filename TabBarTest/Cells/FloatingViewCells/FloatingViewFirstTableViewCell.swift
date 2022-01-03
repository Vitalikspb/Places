//
//  FloatingViewFirstTableViewCell.swift
//  TabBarTest
//
//

import UIKit

class FloatingViewFirstTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Эрмитаж"
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Bold", size: 17)
        return label
    }()
    let typeLocationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Музей"
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        return label
    }()
    let openCloseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.text = "Закрыто"
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        return label
    }()
    let whenOpenLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Откроется в 09:00"
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans", size: 15)
        return label
    }()
    let workInformationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "vosklicanie")
        return imageView
    }()
    let workInformationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "Информация о режиме работы может изменится"
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans", size: 13)
        return label
    }()
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "4.5"
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans", size: 15)
        return label
    }()
    let starView = StackViewStar()
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "(14 731)"
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans", size: 15)
        return label
    }()
    
    let buttonsView = ActionButtonsScrollView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: UIScreen.main.bounds.width,
                                                            height: 60))
    
    // MARK: - Public properties
    
    static let identifier = "FloatingViewFirstTableViewCell"
    
    // MARK: - Private propetries
    
    var countOfRatingStars: Int = 0
    
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
    
    func configCell(title: String, type: String, showButtons: Bool) {
        titleLabel.text = title
        typeLocationLabel.text = type
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.buttonsView.alpha = showButtons ? 0 : 1
            self.buttonsView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        countOfRatingStars = 4
        starView.show(with: countOfRatingStars)
    }
    
    private func setupUI() {
        buttonsView.actionButtonDelegate = self
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(typeLocationLabel)
        contentView.addSubview(buttonsView)
        contentView.addSubview(openCloseLabel)
        contentView.addSubview(whenOpenLabel)
        contentView.addSubview(workInformationLabel)
        contentView.addSubview(workInformationImage)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(starView)
        contentView.addSubview(reviewLabel)
        
        
        
        titleLabel.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: nil,
                          right: rightAnchor,
                          paddingTop: 10,
                          paddingLeft: 10,
                          paddingBottom: 0,
                          paddingRight: 10,
                          width: 0, height: 25)
        typeLocationLabel.anchor(top: titleLabel.bottomAnchor,
                                 left: leftAnchor,
                                 bottom: nil,
                                 right: nil,
                                 paddingTop: 10,
                                 paddingLeft: 10,
                                 paddingBottom: 0,
                                 paddingRight: 10,
                                 width: typeLocationLabel.textWidth(), height: 20)
        ratingLabel.anchor(top: titleLabel.bottomAnchor,
                           left: typeLocationLabel.rightAnchor,
                           bottom: nil,
                           right: nil,
                           paddingTop: 10,
                           paddingLeft: 10,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: ratingLabel.textWidth(), height: 20)
        starView.anchor(top: titleLabel.bottomAnchor,
                        left: ratingLabel.rightAnchor,
                        bottom: nil,
                        right: nil,
                        paddingTop: 10,
                        paddingLeft: 4,
                        paddingBottom: 0,
                        paddingRight: 0,
                        width: CGFloat(countOfRatingStars * 25), height: 20)
        reviewLabel.anchor(top: titleLabel.bottomAnchor,
                           left: starView.rightAnchor,
                           bottom: nil,
                           right: rightAnchor,
                           paddingTop: 10,
                           paddingLeft: 4,
                           paddingBottom: 0,
                           paddingRight: 10,
                           width: 0, height: 20)
        openCloseLabel.anchor(top: typeLocationLabel.bottomAnchor,
                              left: leftAnchor,
                              bottom: nil,
                              right: nil,
                              paddingTop: 10,
                              paddingLeft: 10,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: openCloseLabel.textWidth(), height: 20)
        whenOpenLabel.anchor(top: typeLocationLabel.bottomAnchor,
                             left: openCloseLabel.rightAnchor,
                             bottom: nil,
                             right: rightAnchor,
                             paddingTop: 10,
                             paddingLeft: 10,
                             paddingBottom: 0,
                             paddingRight: 10,
                             width: 0, height: 20)
        workInformationImage.anchor(top: openCloseLabel.bottomAnchor,
                                    left: leftAnchor,
                                    bottom: nil,
                                    right: nil,
                                    paddingTop: 7,
                                    paddingLeft: 10,
                                    paddingBottom: 0,
                                    paddingRight: 0,
                                    width: 25, height: 25)
        workInformationLabel.anchor(top: openCloseLabel.bottomAnchor,
                                    left: workInformationImage.rightAnchor,
                                    bottom: nil,
                                    right: rightAnchor,
                                    paddingTop: 10,
                                    paddingLeft: 10,
                                    paddingBottom: 0,
                                    paddingRight: 0,
                                    width: 0, height: 20)
        buttonsView.anchor(top: workInformationImage.bottomAnchor,
                           left: leftAnchor,
                           bottom: bottomAnchor,
                           right: rightAnchor,
                           paddingTop: 5,
                           paddingLeft: 0,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 0, height: 60)
    }
}

// MARK: - ActionButtonsScrollViewDelegate

extension FloatingViewFirstTableViewCell: ActionButtonsScrollViewDelegate {
    func siteButtonTapped() {
        print("siteButtonTapped")
    }
    
    func routeButtonTapped() {
        print("routeButtonTapped")
    }
    
    func addToFavouritesButtonTapped() {
        print("addToFavouritesButtonTapped")
    }
    
    func callButtonTapped() {
        print("callButtonTapped")
    }
    
    func shareButtonTapped() {
        print("shareButtonTapped")
    }
}

