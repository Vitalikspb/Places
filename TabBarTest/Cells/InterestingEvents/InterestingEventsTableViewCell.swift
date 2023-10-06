//
//  CountryPhotosTableViewCell.swift
//  TabBarTest
//
//

import UIKit

class InterestingEventsTableViewCell: UITableViewCell {
    
    // MARK: - UI properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        return label
    }()
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    // MARK: - Public properties
    
    static let identifier = "InterestingEventsTableViewCell"
    
    // MARK: - Private properties
    
    struct InterestingEventsModel {
        var name,
            date,
            description: String
        var image: UIImage
    }
    
    private var model: InterestingEventsModel?
    
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
    
    func configureCell(model: InterestingEventsModel) {
        self.model = model
        titleLabel.text = model.name
        dateLabel.text = model.date
        mainImageView.image = model.image
    }
    
    private func setupUI() {
        self.clipsToBounds = true
        let bgColorView = UIView()
        bgColorView.backgroundColor = .white
        self.selectedBackgroundView = bgColorView
        
        contentView.addSubviews(titleLabel, mainImageView, dateLabel)

        mainImageView.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             bottom: nil,
                             right: contentView.rightAnchor,
                             paddingTop: 16,
                             paddingLeft: 16,
                             paddingBottom: 0,
                             paddingRight: 16,
                             width: 0,
                             height: 0)
        
        titleLabel.anchor(top: mainImageView.bottomAnchor,
                          left: contentView.leftAnchor,
                          bottom: nil,
                          right: contentView.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0,
                          height: 30)
        dateLabel.anchor(top: titleLabel.bottomAnchor,
                         left: contentView.leftAnchor,
                         bottom: contentView.bottomAnchor,
                         right: contentView.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 16,
                         paddingBottom: 8,
                         paddingRight: 16,
                         width: 0,
                         height: 30)
        
    }
}
