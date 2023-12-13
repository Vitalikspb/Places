//
//  FloatingViewFirstTableViewCell.swift
//  TabBarTest
//
//

import UIKit
import CoreLocation

protocol FloatingViewFirstTableViewCellDelegate: AnyObject {
    func routeButtonTapped(location: CLLocationCoordinate2D)
    func addToFavouritesButtonTapped(name: String)
    func callButtonTapped(withNumber: String)
    func siteButtonTapped(urlString: String)
}

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
        label.text = ""
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
        return imageView
    }()
    let typeLocationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.text = ""
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 14)
        return label
    }()
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.text = ""
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 14)
        return label
    }()
    let starView = StackViewStar()
    
    let buttonsView = ActionButtonsScrollView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: UIScreen.main.bounds.width,
                                                            height: 60))
    
    // MARK: - Public properties
    
    weak var delegate: FloatingViewFirstTableViewCellDelegate?
    static let identifier = "FloatingViewFirstTableViewCell"
    
    // MARK: - Private properties
    
    private var smallView: Bool = true
    private var model: Sight?
    
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
        titleLabel.text = nil
        typeLocationLabel.text = nil
        ratingLabel.text = nil
        typeSightImageView.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Helper functions
    
    func configCell(model: Sight, showButtons: Bool, smallView: Bool = true) {
        self.model = model
        titleLabel.text = model.name
        typeLocationLabel.text = model.type.rawValue
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.buttonsView.alpha = showButtons ? 0 : 1
            self.buttonsView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            self.buttonsView.setupFavoriteName(sight: model)
            self.buttonsView.actionButtonDelegate = self
        }
        
        self.smallView = smallView
        ratingLabel.text = model.rating
        let imagesCount = Int(model.rating.components(separatedBy: ".").first ?? "0") ?? 0
        starView.show(with: imagesCount)
        
        var iconName = UIImage()
        switch model.type {
        case .sightSeen:
            iconName = UIImage(named: "museum") ?? UIImage()
        case .museum:
            iconName = UIImage(named: "museumSearch") ?? UIImage()
        case .cultureObject:
            iconName = UIImage(named: "museumSearch") ?? UIImage()
        case .god:
            iconName = UIImage(named: "temple") ?? UIImage()
        case .favorite:
            break
        }
        typeSightImageView.image = iconName
    }
    
    private func setupUI() {
        contentView.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        buttonsView.actionButtonDelegate = self
        contentView.addSubviews(mainContainerView, buttonsView)
        
        mainContainerView.addSubviews(titleLabel, typeSightImageView, typeLocationLabel, ratingLabel, starView)
        
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
        ratingLabel.anchor(top: titleLabel.bottomAnchor,
                           left: typeLocationLabel.rightAnchor,
                           bottom: nil,
                           right: nil,
                           paddingTop: 11,
                           paddingLeft: 10,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: ratingLabel.textWidth(), height: 20)
        starView.anchor(top: titleLabel.bottomAnchor,
                        left: ratingLabel.rightAnchor,
                        bottom: nil,
                        right: nil,
                        paddingTop: 12,
                        paddingLeft: 8,
                        paddingBottom: 0,
                        paddingRight: 0,
                        width: 0, height: 15)
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
    
    func routeButtonTapped(location: CLLocationCoordinate2D) {
        delegate?.routeButtonTapped(location: location)
    }
    
    func addToFavouritesButtonTapped(name: String) {
        delegate?.addToFavouritesButtonTapped(name: name)
    }
    
    func callButtonTapped(withNumber: String) {
        delegate?.callButtonTapped(withNumber: withNumber)
    }
    
    func siteButtonTapped(urlString: String) {
        delegate?.siteButtonTapped(urlString: urlString)
    }
    

}


