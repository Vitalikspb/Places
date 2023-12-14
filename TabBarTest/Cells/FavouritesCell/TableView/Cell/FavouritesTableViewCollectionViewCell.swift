//
//  FavouritesTableViewCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol FavouritesTableViewCollectionViewCellDelegate: AnyObject {
    func tapFavouriteButton(name: String)
    func showCity(name: String)
}

// Класс ячейки для всего списка достопримечательнойстей
// отображается сверху экрана сохраненных достопримечательностей
class FavouritesTableViewCollectionViewCell: UICollectionViewCell, Reusable {
    
    // MARK: - UI properties
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    let mainImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.tintColor = .setCustomColor(color: .titleText)
        return image
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        return label
    }()
    let typeSightImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.tintColor = .setCustomColor(color: .tabBarIconSelected)
        image.backgroundColor = .clear
        image.image = UIImage(named: "museum")
        
        return image
    }()
    let typeSightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        return label
    }()
    private let favouriteButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
        return button
    }()
    private let favouriteButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .setCustomColor(color: .mainView)
        view.layer.cornerRadius = 6
        return view
    }()
    private let favouriteButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = .setCustomColor(color: .titleText)
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "favouriteImage")
        return imageView
    }()
    
    // MARK: - Public properties
    
    weak var delegate: FavouritesTableViewCollectionViewCellDelegate?
    static let identifier = "FavouritesTableViewCollectionViewCell"
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    
    func configureCell(withName title: String, typeSight: String, andImage image: UIImage) {
        titleLabel.text = title
        typeSightLabel.text = typeSight
        mainImageView.image = image
        favouriteButtonView.backgroundColor = .setCustomColor(color: .tabBarIconSelected)
    }
    
    private func setupUI() {
        let mapTap = UITapGestureRecognizer(target: self, action: #selector(moveToCityViewHandle))
        mainImageView.isUserInteractionEnabled = true
        mainImageView.addGestureRecognizer(mapTap)
        
        favouriteButton.delegate = self
        
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        contentView.addSubviews(mainView)
        mainView.addConstraintsToFillView(view: contentView)
        
        mainView.addSubviews(mainImageView, titleLabel, typeSightLabel, typeSightImageView, favouriteButton)
        favouriteButton.addSubviews(favouriteButtonView)
        favouriteButtonView.addSubviews(favouriteButtonImageView)

        
        mainImageView.anchor(top: mainView.topAnchor,
                             left: mainView.leftAnchor,
                             bottom: nil,
                             right: mainView.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0, height: 0)
        
        titleLabel.anchor(top: mainImageView.bottomAnchor,
                          left: mainView.leftAnchor,
                          bottom: nil,
                          right: nil,
                          paddingTop: 4,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0, height: 25)
        typeSightImageView.anchor(top: titleLabel.bottomAnchor,
                                  left: mainView.leftAnchor,
                                  bottom: mainView.bottomAnchor,
                                  right: nil,
                                  paddingTop: 4,
                                  paddingLeft: 20,
                                  paddingBottom: 4,
                                  paddingRight: 0,
                                  width: 16, height: 16)
        typeSightLabel.anchor(top: titleLabel.bottomAnchor,
                                  left: typeSightImageView.rightAnchor,
                                  bottom: mainView.bottomAnchor,
                                  right: nil,
                                  paddingTop: 4,
                                  paddingLeft: 10,
                                  paddingBottom: 4,
                                  paddingRight: 0,
                                  width: 0, height: 20)
        favouriteButton.anchor(top: mainImageView.topAnchor,
                             left: nil,
                             bottom: nil,
                             right: mainImageView.rightAnchor,
                             paddingTop: 8,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 8,
                             width: 35, height: 35)
        favouriteButtonView.addConstraintsToFillView(view: favouriteButton)
        favouriteButtonImageView.addConstraintsToFillView(view: favouriteButtonView)
    }
    
    // MARK: - Selectors
    
    @objc private func moveToCityViewHandle() {
        delegate?.showCity(name: titleLabel.text ?? "")
    }

}

// MARK: - CustomAnimatedButtonDelegate

extension FavouritesTableViewCollectionViewCell: CustomAnimatedButtonDelegate {
    
    func continueButton(id: Int) {
        delegate?.tapFavouriteButton(name: titleLabel.text ?? "")
    }

}

