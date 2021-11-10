//
//  FloatingViewThirdTableViewCell.swift
//  TabBarTest
//
//

import UIKit

class FloatingViewThirdTableViewCell: UITableViewCell {
    
    // MARK: - Public properties
    
    static let identifier = "FloatingViewThirdTableViewCell"
    
    // MARK: - Private properties
    
    var urlSite = "www.awesomemuseum.ru"
    
    // MARK: - UI properties
    
    let addressImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "vosklicanie")
        return imageView
    }()
    let addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        return label
    }()
    let addressDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans", size: 13)
        return label
    }()
    let separatorAddressView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let contactsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "vosklicanie")
        return imageView
    }()
    let contactsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        return label
    }()
    let contactsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans", size: 13)
        return label
    }()
    let contactsSiteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans", size: 15)
        return label
    }()
    let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    let vkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.setImage(UIImage(named: "star"), for: .normal)
        button.tintColor = .black
        return button
    }()
    let fbButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.setImage(UIImage(named: "star"), for: .normal)
        return button
    }()
    let instButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.setImage(UIImage(named: "star"), for: .normal)
        return button
    }()
    let ytButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.setImage(UIImage(named: "star"), for: .normal)
        return button
    }()
    let separatorContactsView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let workTimeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "vosklicanie")
        return imageView
    }()
    let workTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        return label
    }()
    let openCloseWorkTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        return label
    }()
    let workTimeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans", size: 13)
        return label
    }()
    
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
    
    func configCell(title: String) {
        
    }
    
    private func setupUI() {
        contentView.addSubview(addressImage)
        contentView.addSubview(addressLabel)
        contentView.addSubview(addressDescriptionLabel)
        contentView.addSubview(separatorAddressView)
        
        contentView.addSubview(contactsImage)
        contentView.addSubview(contactsLabel)
        contentView.addSubview(contactsDescriptionLabel)
        contentView.addSubview(contactsSiteLabel)
        buttonsStackView.addArrangedSubview(vkButton)
        buttonsStackView.addArrangedSubview(fbButton)
        buttonsStackView.addArrangedSubview(instButton)
        buttonsStackView.addArrangedSubview(ytButton)
        contentView.addSubview(buttonsStackView)
        contentView.addSubview(separatorContactsView)
        
        contentView.addSubview(workTimeImage)
        contentView.addSubview(workTimeLabel)
        contentView.addSubview(openCloseWorkTimeLabel)
        contentView.addSubview(workTimeDescriptionLabel)
        
        setupButtons()
        setupConstraints()
        
        addressLabel.text = "Адрес:"
        addressDescriptionLabel.text = "Невский проспект д.48"
        
        contactsLabel.text = "Контакты:"
        contactsDescriptionLabel.text = "+7(123)-456-78-90"
        contactsSiteLabel.text = urlSite
        
        workTimeLabel.text = "Режим работы:"
        openCloseWorkTimeLabel.text = "Открыто"
        workTimeDescriptionLabel.text = "- Работает с 10-00"
    }
    
    private func setupButtons() {
        let tapCall = UITapGestureRecognizer(target: self, action: #selector(makeCall))
        contactsDescriptionLabel.addGestureRecognizer(tapCall)
        contactsDescriptionLabel.isUserInteractionEnabled = true
        
        let tapSite = UITapGestureRecognizer(target: self, action: #selector(gotoSite))
        contactsSiteLabel.addGestureRecognizer(tapSite)
        contactsSiteLabel.isUserInteractionEnabled = true
    }
    
    private func setupConstraints() {
        addressImage.anchor(top: topAnchor,
                            left: leftAnchor,
                            bottom: nil,
                            right: nil,
                            paddingTop: 10,
                            paddingLeft: 10,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 30, height: 30)
        addressLabel.anchor(top: topAnchor,
                            left: addressImage.rightAnchor,
                            bottom: nil,
                            right: rightAnchor,
                            paddingTop: 14,
                            paddingLeft: 10,
                            paddingBottom: 0,
                            paddingRight: 10,
                            width: 0, height: 20)
        addressDescriptionLabel.anchor(top: addressLabel.bottomAnchor,
                                       left: addressImage.rightAnchor,
                                       bottom: nil,
                                       right: rightAnchor,
                                       paddingTop: 10,
                                       paddingLeft: 10,
                                       paddingBottom: 0,
                                       paddingRight: 10,
                                       width: 0, height: 20)
        separatorAddressView.anchor(top: addressDescriptionLabel.bottomAnchor,
                                    left: leftAnchor,
                                    bottom: nil,
                                    right: rightAnchor,
                                    paddingTop: 10,
                                    paddingLeft: 15,
                                    paddingBottom: 0,
                                    paddingRight: 15,
                                    width: 0, height: 1)
        
        contactsImage.anchor(top: separatorAddressView.bottomAnchor,
                             left: leftAnchor,
                             bottom: nil,
                             right: nil,
                             paddingTop: 15,
                             paddingLeft: 10,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 30, height: 30)
        contactsLabel.anchor(top: separatorAddressView.bottomAnchor,
                             left: contactsImage.rightAnchor,
                             bottom: nil,
                             right: rightAnchor,
                             paddingTop: 19,
                             paddingLeft: 10,
                             paddingBottom: 0,
                             paddingRight: 10,
                             width: 0, height: 20)
        contactsDescriptionLabel.anchor(top: contactsLabel.bottomAnchor,
                                        left: contactsImage.rightAnchor,
                                        bottom: nil,
                                        right: rightAnchor,
                                        paddingTop: 10,
                                        paddingLeft: 10,
                                        paddingBottom: 0,
                                        paddingRight: 10,
                                        width: 0, height: 20)
        contactsSiteLabel.anchor(top: contactsDescriptionLabel.bottomAnchor,
                                 left: contactsImage.rightAnchor,
                                 bottom: nil,
                                 right: rightAnchor,
                                 paddingTop: 10,
                                 paddingLeft: 10,
                                 paddingBottom: 0,
                                 paddingRight: 10,
                                 width: 0, height: 20)
        buttonsStackView.anchor(top: contactsSiteLabel.bottomAnchor,
                                left: contactsImage.rightAnchor,
                                bottom: nil,
                                right: nil,
                                paddingTop: 15,
                                paddingLeft: 10,
                                paddingBottom: 0,
                                paddingRight: 0,
                                width: 190, height: 35)
        separatorContactsView.anchor(top: buttonsStackView.bottomAnchor,
                                     left: leftAnchor,
                                     bottom: nil,
                                     right: rightAnchor,
                                     paddingTop: 10,
                                     paddingLeft: 15,
                                     paddingBottom: 0,
                                     paddingRight: 15,
                                     width: 0, height: 1)
        
        workTimeImage.anchor(top: separatorContactsView.bottomAnchor,
                             left: leftAnchor,
                             bottom: nil,
                             right: nil,
                             paddingTop: 15,
                             paddingLeft: 10,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 30, height: 30)
        
        workTimeLabel.anchor(top: separatorContactsView.bottomAnchor,
                             left: workTimeImage.rightAnchor,
                             bottom: nil,
                             right: rightAnchor,
                             paddingTop: 19,
                             paddingLeft: 10,
                             paddingBottom: 0,
                             paddingRight: 10,
                             width: 0, height: 20)
        openCloseWorkTimeLabel.anchor(top: workTimeLabel.bottomAnchor,
                                      left: workTimeImage.rightAnchor,
                                      bottom: bottomAnchor,
                                      right: nil,
                                      paddingTop: 10,
                                      paddingLeft: 10,
                                      paddingBottom: 10,
                                      paddingRight: 0,
                                      width: 0, height: 20)
        workTimeDescriptionLabel.anchor(top: workTimeLabel.bottomAnchor,
                                        left: openCloseWorkTimeLabel.rightAnchor,
                                        bottom: bottomAnchor,
                                        right: nil,
                                        paddingTop: 8,
                                        paddingLeft: 5,
                                        paddingBottom: 5,
                                        paddingRight: 10,
                                        width: 0, height: 20)
    }
}
