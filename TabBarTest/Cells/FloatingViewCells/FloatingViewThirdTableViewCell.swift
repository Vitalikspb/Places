//
//  FloatingViewThirdTableViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol FloatingViewThirdTableViewCellDelegate: AnyObject {
    func makeCall()
    func openSite()
    func openVK()
    func openFaceBook()
    func openInstagram()
    func openYoutube()
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
        label.text = "Адрес"
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 16)
        return label
    }()
    let addressDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans", size: 16)
        label.text = "Невский проспект д.48"
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
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 16)
        label.text = "Контакты"
        return label
    }()
    let contactsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans", size: 16)
        label.text = "Телефон:"
        return label
    }()
    let contactsPhoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .weatherBlueBackground)
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans", size: 16)
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
    let siteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        button.layer.cornerRadius = 4
        button.setImage(UIImage(named: "site"), for: .normal)
        button.imageView?.contentMode = .center
        return button
    }()
    let vkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        button.layer.cornerRadius = 4
        button.setImage(UIImage(named: "vkontakte"), for: .normal)
        button.imageView?.contentMode = .center
        return button
    }()
    let fbButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        button.layer.cornerRadius = 4
        button.setImage(UIImage(named: "facebook"), for: .normal)
        button.imageView?.contentMode = .center
        return button
    }()
    let instButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        button.layer.cornerRadius = 4
        button.setImage(UIImage(named: "instagram"), for: .normal)
        button.imageView?.contentMode = .center
        return button
    }()
    let ytButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        button.layer.cornerRadius = 4
        button.setImage(UIImage(named: "youtube"), for: .normal)
        button.imageView?.contentMode = .center
        return button
    }()
    
    // MARK: - Public properties
    
    static let identifier = "FloatingViewThirdTableViewCell"
    weak var delegate: FloatingViewThirdTableViewCellDelegate?
    // MARK: - Private properties
    
    var urlSite = "www.awesomemuseum.ru"
    
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
    
    @objc func makeCall() {
        
    }
    
    @objc func gotoSite() {
        
    }
    
    // MARK: - Helper functions
    
    func configCell(address: String, phone: String) {
        addressDescriptionLabel.text = "Невский проспект д.48"
        contactsPhoneLabel.text = "+7(123)-456-78-90"
    }

    private func setupUI() {
        let tapPhone = UITapGestureRecognizer(target: self, action: #selector(phoneTapped))
        contactsPhoneLabel.isUserInteractionEnabled = true
        contactsPhoneLabel.addGestureRecognizer(tapPhone)
        siteButton.addTarget(self, action: #selector(siteTapped), for: .touchUpInside)
        vkButton.addTarget(self, action: #selector(vkTapped), for: .touchUpInside)
        fbButton.addTarget(self, action: #selector(facebookTapped), for: .touchUpInside)
        instButton.addTarget(self, action: #selector(instagramTapped), for: .touchUpInside)
        ytButton.addTarget(self, action: #selector(youtubeTapped), for: .touchUpInside)
        
        contentView.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        
        contentView.addSubviews(addresView, contactsView)
        addresView.addSubviews(addressImage, addressLabel, addressDescriptionLabel)
        contactsView.addSubviews(contactsImage, contactsLabel, contactsDescriptionLabel, contactsPhoneLabel, buttonsStackView)

        buttonsStackView.addArrangedSubview(siteButton)
        buttonsStackView.addArrangedSubview(vkButton)
        buttonsStackView.addArrangedSubview(fbButton)
        buttonsStackView.addArrangedSubview(instButton)
        buttonsStackView.addArrangedSubview(ytButton)
        
        setupButtons()
        setupConstraints()
    }
    
    private func setupButtons() {
        let tapCall = UITapGestureRecognizer(target: self, action: #selector(makeCall))
        contactsDescriptionLabel.addGestureRecognizer(tapCall)
        contactsDescriptionLabel.isUserInteractionEnabled = true
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
                          width: 0, height: 72)
        
        
        
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
                            width: 0, height: 0)
        addressDescriptionLabel.anchor(top: addressLabel.bottomAnchor,
                                       left: addressImage.rightAnchor,
                                       bottom: nil,
                                       right: addresView.rightAnchor,
                                       paddingTop: 10,
                                       paddingLeft: 8,
                                       paddingBottom: 0,
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
                                width: 233, height: 56)

    }
    
    // MARK: - Selectors
    
    @objc private func phoneTapped() {
        delegate?.makeCall()
    }
    
    @objc private func siteTapped() {
        delegate?.openSite()
    }
    
    @objc private func vkTapped() {
        delegate?.openVK()
    }
    
    @objc private func facebookTapped() {
        delegate?.openFaceBook()
    }
    
    @objc private func instagramTapped() {
        delegate?.openInstagram()
    }
    
    @objc private func youtubeTapped() {
        delegate?.openYoutube()
    }
}
