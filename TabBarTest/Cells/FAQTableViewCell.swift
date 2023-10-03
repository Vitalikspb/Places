//
//  FAQTableViewCell.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import UIKit

class FAQTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    private let headerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        return view
    }()
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = .setCustomFont(name: .bold, andSize: 20)
        return label
    }()
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = .setCustomFont(name: .regular, andSize: 16)
        return label
    }()
    
    // MARK: - Public properties
    
    static let identifier = "FAQTableViewCell"
    
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
    
    func configureCell(question: String, answer: String) {
        questionLabel.text = question
        answerLabel.text = answer
    }
    
    private func setupUI() {
        contentView.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        
        contentView.addSubviews(headerView, answerLabel)
        headerView.addSubviews(questionLabel)
        
        headerView.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: nil,
                          right: contentView.rightAnchor,
                          paddingTop: 12,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 0,
                          height: 0)
        questionLabel.anchor(top: headerView.topAnchor,
                             left: headerView.leftAnchor,
                             bottom: headerView.bottomAnchor,
                             right: headerView.rightAnchor,
                             paddingTop: 16,
                             paddingLeft: 16,
                             paddingBottom: 16,
                             paddingRight: 16,
                             width: 0,
                             height: 0)
        answerLabel.anchor(top: headerView.bottomAnchor,
                           left: contentView.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor,
                           paddingTop: 16,
                           paddingLeft: 16,
                           paddingBottom: 16,
                           paddingRight: 16,
                           width: 0,
                           height: 0)
    }
}
