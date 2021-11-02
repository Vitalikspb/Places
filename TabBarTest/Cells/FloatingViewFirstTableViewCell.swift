//
//  FloatingViewFirstTableViewCell.swift
//  TabBarTest
//
//  Created by ViceCode on 29.10.2021.
//

import UIKit

class FloatingViewFirstTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Супер интересный музей"
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Bold", size: 17)
        return label
    }()
    let typeLocationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "Музей"
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-SemiBold", size: 15)
        return label
    }()
    let buttonsView = ActionButtonsScrollView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: UIScreen.main.bounds.width,
                                                            height: 60))
    
    // MARK: - Public properties
    
    static let identifier = "FloatingViewFirstTableViewCell"
    
    // MARL: - Lifecycle
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
    
    // MARL: - Helper functions
    
    func configCell(title: String, type: String, showButtons: Bool) {
        titleLabel.text = title
        typeLocationLabel.text = type
        UIView.animate(withDuration: 0.32) {
            self.buttonsView.alpha = showButtons ? 0 : 1
        }
    }
    
    private func setupUI() {
        
        buttonsView.actionButtonDelegate = self
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(typeLocationLabel)
        contentView.addSubview(buttonsView)
        
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
                                 right: rightAnchor,
                                 paddingTop: 10,
                                 paddingLeft: 10,
                                 paddingBottom: 0,
                                 paddingRight: 10,
                                 width: 0, height: 25)
        buttonsView.anchor(top: typeLocationLabel.bottomAnchor,
                           left: leftAnchor,
                           bottom: bottomAnchor,
                           right: rightAnchor,
                           paddingTop: 0,
                           paddingLeft: 0,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 0, height: 60)
    }
}

// MARK: - ActionButtonsScrollViewDelegate

extension FloatingViewFirstTableViewCell: ActionButtonsScrollViewDelegate {
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
