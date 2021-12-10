//
//  ButtonsCollectionViewCell.swift
//  TabBarTest
//
//

import UIKit

protocol ButtonsCollectionViewCellDelegate: AnyObject {
    func favouritesHandler()
    func eventsHandler()
    func ticketHandler()
    func faqHandler()
    func rentAutoHandler()
    func chatHandler()
}

class ButtonsCollectionViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    let buttonsTopStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    let savedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Избранное", for: .normal)
        return button
    }()
    let eventsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Интересные \nсобытия", for: .normal)
        return button
    }()
    let ticketsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Билеты на \nэкскурсии", for: .normal)
        return button
    }()
    let buttonsBottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    let FAQButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вопросы и \nответы", for: .normal)
        return button
    }()
    let rentAutoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Аренда \nавтомобиля", for: .normal)
        return button
    }()
    let chatButton: UIButton = {
        let button = UIButton()
        button.setTitle("Чат", for: .normal)
        return button
    }()
    // MARK: -  Public Properties
    
    static let identifier = "ButtonsCollectionViewCell"
    weak var delegate: ButtonsCollectionViewCellDelegate?
    
    // MARK: - LifeCycle
    
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
        self.backgroundColor = .white
        [savedButton, eventsButton, ticketsButton,
         FAQButton, rentAutoButton, chatButton].forEach {
            $0.backgroundColor = .clear
            $0.setTitleColor(.systemBlue, for: .normal)
            $0.titleLabel?.font = UIFont.init(name: "GillSans-semibold", size: 16)
            $0.titleLabel?.numberOfLines = 0
            $0.titleLabel?.textAlignment = .center
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.systemBlue.cgColor
         }
        savedButton.addTarget(self, action: #selector(savedButtonTapped), for: .touchUpInside)
        eventsButton.addTarget(self, action: #selector(eventsButtonTapped), for: .touchUpInside)
        ticketsButton.addTarget(self, action: #selector(ticketsButtonTapped), for: .touchUpInside)
        FAQButton.addTarget(self, action: #selector(FAQButtonTapped), for: .touchUpInside)
        rentAutoButton.addTarget(self, action: #selector(rentAutoButtonTapped), for: .touchUpInside)
        chatButton.addTarget(self, action: #selector(chatButtonTapped), for: .touchUpInside)
        
        
        contentView.addSubview(buttonsTopStackView)
        contentView.addSubview(buttonsBottomStackView)
        
        buttonsTopStackView.addArrangedSubview(savedButton)
        buttonsTopStackView.addArrangedSubview(eventsButton)
        buttonsTopStackView.addArrangedSubview(ticketsButton)
        buttonsBottomStackView.addArrangedSubview(FAQButton)
        buttonsBottomStackView.addArrangedSubview(rentAutoButton)
        buttonsBottomStackView.addArrangedSubview(chatButton)
        
        
        buttonsTopStackView.anchor(top: contentView.topAnchor,
                                   left: contentView.leftAnchor,
                                   bottom: nil,
                                   right: contentView.rightAnchor,
                                   paddingTop: 10,
                                   paddingLeft: 16,
                                   paddingBottom: 0,
                                   paddingRight: 16,
                                   width: 0, height: 60)
        buttonsBottomStackView.anchor(top: nil,
                                      left: contentView.leftAnchor,
                                      bottom: contentView.bottomAnchor,
                                      right: contentView.rightAnchor,
                                      paddingTop: 0,
                                      paddingLeft: 16,
                                      paddingBottom: 10,
                                      paddingRight: 16,
                                      width: 0, height: 60)
    }
    
    @objc func savedButtonTapped() {
        delegate?.favouritesHandler()
    }
    @objc func eventsButtonTapped() {
        delegate?.eventsHandler()
    }
    @objc func ticketsButtonTapped() {
        delegate?.ticketHandler()
    }
    @objc func FAQButtonTapped() {
        delegate?.faqHandler()
    }
    @objc func rentAutoButtonTapped() {
        delegate?.rentAutoHandler()
    }
    @objc func chatButtonTapped() {
        delegate?.chatHandler()
    }
}
