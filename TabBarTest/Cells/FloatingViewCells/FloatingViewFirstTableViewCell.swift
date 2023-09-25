//
//  FloatingViewFirstTableViewCell.swift
//  TabBarTest
//
//

import UIKit

class FloatingViewFirstTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    
    private let mainContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.text = "Эрмитаж"
        label.textAlignment = .left
        label.font = .setCustomFont(name: .bold, andSize: 18)
        return label
    }()
    let typeSightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "vosklicanie")
        return imageView
    }()
    let typeLocationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.text = "Музей"
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 14)
        return label
    }()
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.text = "4.5"
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 14)
        return label
    }()
    let starView = StackViewStar()
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.text = "(14 731)"
        label.textAlignment = .left
        label.font = .setCustomFont(name: .regular, andSize: 14)
        return label
    }()
    
    let buttonsView = ActionButtonsScrollView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: UIScreen.main.bounds.width,
                                                            height: 60))
    
    // MARK: - Public properties
    
    static let identifier = "FloatingViewFirstTableViewCell"
    
    // MARK: - Private properties
    
    private var smallView: Bool = true
    
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
    
    func configCell(title: String, type: String, showButtons: Bool, smallView: Bool = true) {
        titleLabel.text = title
        typeLocationLabel.text = type
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.buttonsView.alpha = showButtons ? 0 : 1
            self.buttonsView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        self.smallView = smallView
        starView.show(with: 1)
    }
    
    private func setupUI() {
        contentView.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        buttonsView.actionButtonDelegate = self
        contentView.addSubviews(mainContainerView, buttonsView)
        
        mainContainerView.addSubviews(titleLabel, typeSightImageView, typeLocationLabel, ratingLabel, starView, reviewLabel)
        
        mainContainerView.anchor(top: topAnchor,
                                 left: leftAnchor,
                                 bottom: nil,
                                 right: rightAnchor,
                                 paddingTop: 0,
                                 paddingLeft: 16,
                                 paddingBottom: 0,
                                 paddingRight: 16,
                                 width: 0, height: 80)
        titleLabel.anchor(top: mainContainerView.topAnchor,
                          left: mainContainerView.leftAnchor,
                          bottom: nil,
                          right: mainContainerView.rightAnchor,
                          paddingTop: 14,
                          paddingLeft: 12,
                          paddingBottom: 0,
                          paddingRight: 12,
                          width: 0, height: 0)
        typeSightImageView.anchor(top: titleLabel.bottomAnchor,
                                  left: mainContainerView.leftAnchor,
                                  bottom: nil,
                                  right: nil,
                                  paddingTop: 12,
                                  paddingLeft: 12,
                                  paddingBottom: 0,
                                  paddingRight: 10,
                                  width: 16, height: 16)
        typeLocationLabel.anchor(top: titleLabel.bottomAnchor,
                                 left: typeSightImageView.rightAnchor,
                                 bottom: nil,
                                 right: nil,
                                 paddingTop: 12,
                                 paddingLeft: 4,
                                 paddingBottom: 0,
                                 paddingRight: 10,
                                 width: typeLocationLabel.textWidth(), height: 0)
        starView.anchor(top: titleLabel.bottomAnchor,
                        left: typeLocationLabel.rightAnchor,
                        bottom: nil,
                        right: nil,
                        paddingTop: 12,
                        paddingLeft: 16,
                        paddingBottom: 0,
                        paddingRight: 0,
                        width: 15, height: 15)
        ratingLabel.anchor(top: titleLabel.bottomAnchor,
                           left: starView.rightAnchor,
                           bottom: nil,
                           right: nil,
                           paddingTop: 11,
                           paddingLeft: 10,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: ratingLabel.textWidth(), height: 20)
        
        reviewLabel.anchor(top: titleLabel.bottomAnchor,
                           left: ratingLabel.rightAnchor,
                           bottom: nil,
                           right: rightAnchor,
                           paddingTop: 12,
                           paddingLeft: 4,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 0, height: 0)
        buttonsView.anchor(top: mainContainerView.bottomAnchor,
                           left: leftAnchor,
                           bottom: nil,
                           right: rightAnchor,
                           paddingTop: 28,
                           paddingLeft: 0,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 0, height: smallView ? 140 : 60)
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

