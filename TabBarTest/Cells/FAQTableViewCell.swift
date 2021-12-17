//
//  FAQTableViewCell.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//

import UIKit

class FAQTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private let questionLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.contentMode = .center
        title.textAlignment = .left
        title.backgroundColor = .clear
        title.numberOfLines = 0
        title.font = UIFont.init(name: "GillSans-SemiBold", size: 16)
        return title
    }()
    private let answerLabel: UILabel = {
        let title = UILabel()
        title.textColor = .darkGray
        title.contentMode = .center
        title.textAlignment = .left
        title.backgroundColor = .clear
        title.numberOfLines = 0
        title.font = UIFont.init(name: "GillSans-SemiBold", size: 16)
        return title
    }()
    private let arrowImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrowtriangle.down.fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .lightGray
        return image
    }()
    
    // MARK: - Public properties
    
    var arrowImage: String = "" {
        didSet {
            arrowImageView.image = UIImage(systemName: arrowImage) ?? UIImage(systemName: "gear")
        }
    }
    static let identifier = "RentAutoTableViewCell"
    
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
    
    private func setupUI() {
        let bgColorView = UIView()
        bgColorView.backgroundColor = .white
        self.selectedBackgroundView = bgColorView
        self.clipsToBounds = true
        
        contentView.addSubview(questionLabel)
        contentView.addSubview(answerLabel)
        contentView.addSubview(arrowImageView)
        
        questionLabel.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             bottom: nil,
                             right: arrowImageView.rightAnchor,
                             paddingTop: 21,
                             paddingLeft: 16,
                             paddingBottom: 0,
                             paddingRight: 8,
                             width: 0, height: 0)
        answerLabel.anchor(top: questionLabel.bottomAnchor,
                           left: contentView.leftAnchor,
                           bottom: nil,
                           right: arrowImageView.rightAnchor,
                           paddingTop: 19,
                           paddingLeft: 16,
                           paddingBottom: 0,
                           paddingRight: 8,
                           width: 0, height: 0)
        arrowImageView.anchor(top: contentView.topAnchor,
                              left: nil,
                              bottom: nil,
                              right: contentView.rightAnchor,
                              paddingTop: 8,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 16,
                              width: 20, height: 20)
    }
    
    func configureCell(question: String, answer: String) {
        questionLabel.text = question
        answerLabel.text = answer
    }
    
}
