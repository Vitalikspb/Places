//
//  FloatingViewThirdTableViewCell.swift
//  TabBarTest
//
//

import UIKit
import CoreLocation

protocol FloatingViewThirdTableViewCellDelegate: AnyObject {
    func openUrl(name: String)
}

class FloatingViewThirdTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    
    let addresView: UIView = {
       let view = UIView()
        view.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    let addressImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        imageView.contentMode = .center
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "addressFloating")
        return imageView
    }()
    let addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.text = "Адрес:"
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        return label
    }()
    let addressDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .regular, andSize: 16)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    let contactsView: UIView = {
       let view = UIView()
        view.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    let contactsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        imageView.contentMode = .center
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "contactsFloating")
        return imageView
    }()
    let contactsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        label.text = "Контакты:"
        return label
    }()
    let contactsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .regular, andSize: 16)
        label.text = "Телефон:"
        return label
    }()
    let contactsPhoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .regular, andSize: 16)
        label.text = "+7(123)-456-78-90"
        return label
    }()
    
    let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 12
        stack.axis = .horizontal
        return stack
    }()
    
    let vkButton: UIImageView = {
        let button = UIImageView()
        button.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        button.layer.cornerRadius = 4
        button.image = UIImage(named: "vkontakte")
        button.contentMode = .center
        return button
    }()
    private let animateVKButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
        button.setupId(id: 1)
        return button
    }()
    
    let fbButton: UIImageView = {
        let button = UIImageView()
        button.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        button.layer.cornerRadius = 4
        button.image = UIImage(named: "facebook")
        button.contentMode = .center
        return button
    }()
    private let animateFBButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
        button.setupId(id: 2)
        return button
    }()
    
    let instButton: UIImageView = {
        let button = UIImageView()
        button.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        button.layer.cornerRadius = 4
        button.image = UIImage(named: "instagram")
        button.contentMode = .center
        return button
    }()
    private let animateInstButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
        button.setupId(id: 3)
        return button
    }()
    
    let ytButton: UIImageView = {
        let button = UIImageView()
        button.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        button.layer.cornerRadius = 4
        button.image = UIImage(named: "youtube")
        button.contentMode = .center
        return button
    }()
    private let animateYOUButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
        button.setupId(id: 4)
        return button
    }()
    
    
    // MARK: - Public properties
    
    static let identifier = "FloatingViewThirdTableViewCell"
    weak var delegate: FloatingViewThirdTableViewCellDelegate?
    
    // MARK: - Private properties
    
    private var sight: Sight?
    
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
    
    // MARK: - Selectors
    
    @objc func openUrl(id: Int) {
        if let sight = sight {
            switch id {
            case 1:
                delegate?.openUrl(name: sight.vk ?? "")
            case 2:
                delegate?.openUrl(name: sight.facebook ?? "")
            case 3:
                delegate?.openUrl(name: sight.instagram ?? "")
            case 4:
                delegate?.openUrl(name: sight.youtube ?? "")
            default: break
            }
        }
    }
    
    // MARK: - Helper functions
    
    func configCell(model: Sight) {
        addressDescriptionLabel.text = model.address
        contactsPhoneLabel.text = model.main_phone
        sight = model
        
        if sight?.vk != nil {
            animateVKButton.isHidden = false
        }
        if sight?.facebook != nil {
            animateFBButton.isHidden = false
        }
        if sight?.instagram != nil {
            animateInstButton.isHidden = false
        }
        if sight?.youtube != nil {
            animateYOUButton.isHidden = false
        }
    }

    private func setupUI() {
        [animateVKButton, animateFBButton, animateInstButton, animateYOUButton].forEach {
            $0.isHidden = true
        }
                
        contentView.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        contentView.addSubviews(addresView, contactsView)
        addresView.addSubviews(addressImage, addressLabel, addressDescriptionLabel)
        contactsView.addSubviews(contactsImage, contactsLabel, contactsDescriptionLabel, 
                                 contactsPhoneLabel, buttonsStackView)
        
        animateVKButton.addSubviews(vkButton)
        vkButton.addConstraintsToFillView(view: animateVKButton)
        buttonsStackView.addArrangedSubview(animateVKButton)
        
        animateFBButton.addSubviews(fbButton)
        fbButton.addConstraintsToFillView(view: animateFBButton)
        buttonsStackView.addArrangedSubview(animateFBButton)
        
        animateInstButton.addSubviews(instButton)
        instButton.addConstraintsToFillView(view: animateInstButton)
        buttonsStackView.addArrangedSubview(animateInstButton)
        
        animateYOUButton.addSubviews(ytButton)
        ytButton.addConstraintsToFillView(view: animateYOUButton)
        buttonsStackView.addArrangedSubview(animateYOUButton)
        
        setupButtons()
        setupConstraints()
    }
    
    private func setupButtons() {
        let tapRoute = UITapGestureRecognizer(target: self, action: #selector(openUrl(id:)))
        animateVKButton.addGestureRecognizer(tapRoute)
        animateVKButton.isUserInteractionEnabled = true
        
        let tapFavorite = UITapGestureRecognizer(target: self, action: #selector(openUrl(id:)))
        animateFBButton.addGestureRecognizer(tapFavorite)
        animateFBButton.isUserInteractionEnabled = true
        
        let tapCall = UITapGestureRecognizer(target: self, action: #selector(openUrl(id:)))
        animateInstButton.addGestureRecognizer(tapCall)
        animateInstButton.isUserInteractionEnabled = true
        
        let tapSite = UITapGestureRecognizer(target: self, action: #selector(openUrl(id:)))
        animateYOUButton.addGestureRecognizer(tapSite)
        animateYOUButton.isUserInteractionEnabled = true
    }
    
    private func setupConstraints() {
        addresView.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: nil,
                          right: rightAnchor,
                          paddingTop: 8,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 0, height: 0)
        
        
        
        addressImage.anchor(top: addresView.topAnchor,
                            left: addresView.leftAnchor,
                            bottom: nil,
                            right: nil,
                            paddingTop: 16,
                            paddingLeft: 12,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 18, height: 18)
        
        addressLabel.anchor(top: addresView.topAnchor,
                            left: addressImage.rightAnchor,
                            bottom: nil,
                            right: addresView.rightAnchor,
                            paddingTop: 14,
                            paddingLeft: 8,
                            paddingBottom: 0,
                            paddingRight: 8,
                            width: 0, height: 14)
        addressDescriptionLabel.anchor(top: addressLabel.bottomAnchor,
                                       left: addressImage.rightAnchor,
                                       bottom: addresView.bottomAnchor,
                                       right: addresView.rightAnchor,
                                       paddingTop: 10,
                                       paddingLeft: 8,
                                       paddingBottom: 14,
                                       paddingRight: 8,
                                       width: 0, height: 0)
        
        contactsView.anchor(top: addresView.bottomAnchor,
                          left: leftAnchor,
                          bottom: nil,
                          right: rightAnchor,
                          paddingTop: 16,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 0, height: 132)
        
        contactsImage.anchor(top: contactsView.topAnchor,
                             left: contactsView.leftAnchor,
                             bottom: nil,
                             right: nil,
                             paddingTop: 16,
                             paddingLeft: 12,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 18, height: 18)
        contactsLabel.anchor(top: contactsView.topAnchor,
                             left: contactsImage.rightAnchor,
                             bottom: nil,
                             right: contactsView.rightAnchor,
                             paddingTop: 14,
                             paddingLeft: 8,
                             paddingBottom: 0,
                             paddingRight: 8,
                             width: 0, height: 20)
        contactsDescriptionLabel.anchor(top: contactsLabel.bottomAnchor,
                                        left: contactsImage.rightAnchor,
                                        bottom: nil,
                                        right: nil,
                                        paddingTop: 10,
                                        paddingLeft: 8,
                                        paddingBottom: 0,
                                        paddingRight: 0,
                                        width: contactsDescriptionLabel.textWidth(), height: 20)
        contactsPhoneLabel.anchor(top: contactsLabel.bottomAnchor,
                                  left: contactsDescriptionLabel.rightAnchor,
                                  bottom: nil,
                                  right: contactsView.rightAnchor,
                                  paddingTop: 10,
                                  paddingLeft: 4,
                                  paddingBottom: 0,
                                  paddingRight: 8,
                                  width: 0, height: 20)
        buttonsStackView.anchor(top: contactsDescriptionLabel.bottomAnchor,
                                left: contactsImage.rightAnchor,
                                bottom: contactsView.bottomAnchor,
                                right: nil,
                                paddingTop: 12,
                                paddingLeft: 8,
                                paddingBottom: 12,
                                paddingRight: 0,
                                width: 0, height: 56)

    }

}
