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
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
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
    private let mainTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = ""
        return label
    }()
    
    // MARK: - Public properties
    
    static let identifier = "InterestingEventsTableViewCell"
    
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
        // Для обрезания длинного текста описания события
        self.clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(mainImageView)
        contentView.addSubview(mainTextLabel)
        contentView.addSubview(dateLabel)
        
        titleLabel.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: nil,
                          right: nil,
                          paddingTop: 8,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0,
                          height: 0)
        dateLabel.anchor(top: contentView.topAnchor,
                         left: titleLabel.rightAnchor,
                         bottom: nil,
                         right: contentView.rightAnchor,
                         paddingTop: 8,
                         paddingLeft: 16,
                         paddingBottom: 0,
                         paddingRight: 16,
                         width: 0,
                         height: 0)
        mainImageView.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             bottom: nil,
                             right: contentView.rightAnchor,
                             paddingTop: 35,
                             paddingLeft: 16,
                             paddingBottom: 0,
                             paddingRight: 16,
                             width: 0,
                             height: 170)
        mainTextLabel.anchor(top: mainImageView.bottomAnchor,
                             left: contentView.leftAnchor,
                             bottom: contentView.bottomAnchor,
                             right: contentView.rightAnchor,
                             paddingTop: 10,
                             paddingLeft: 16,
                             paddingBottom: 5,
                             paddingRight: 16,
                             width: 0, height: 0)
    }
    
    func configureCell(title: String, description: String, date: String, image: UIImage) {
        mainTextLabel.text = description
        titleLabel.text = title
        dateLabel.text = date
        mainImageView.image = image
    }
}
