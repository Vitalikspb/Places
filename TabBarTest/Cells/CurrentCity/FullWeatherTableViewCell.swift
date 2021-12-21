//
//  FullWeatherTableViewCell.swift
//  TabBarTest
//
//  Created by ViceCode on 21.12.2021.
//

import UIKit

class FullWeatherTableViewCell: UITableViewCell {
    
    private let currentDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
        label.text = "Понедельник"
        return label
    }()
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = "-10"
        return label
    }()
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = "10"
        return label
    }()
    private let curImageImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = "Ясно"
        return label
    }()
    
    static let identifier = "FullWeatherTableViewCell"
    
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
    
    func setupUI() {
        self.backgroundColor = .white
        
        
        contentView.addSubview(currentDayLabel)
        contentView.addSubview(minTempLabel)
        contentView.addSubview(maxTempLabel)
        contentView.addSubview(curImageImageView)
        contentView.addSubview(descriptionLabel)
        
        currentDayLabel.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: nil,
                          right: nil,
                          paddingTop: 8,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 200, height: 25)
        minTempLabel.anchor(top: currentDayLabel.bottomAnchor,
                             left: contentView.leftAnchor,
                             bottom: contentView.bottomAnchor,
                             right: maxTempLabel.leftAnchor,
                             paddingTop: 8,
                             paddingLeft: 16,
                             paddingBottom: 16,
                             paddingRight: 8,
                             width: 70, height: 25)
        maxTempLabel.anchor(top: currentDayLabel.bottomAnchor,
                            left: nil,
                            bottom: contentView.bottomAnchor,
                            right: nil,
                            paddingTop: 8,
                            paddingLeft: 0,
                            paddingBottom: 16,
                            paddingRight: 0,
                            width: 70, height: 25)
        curImageImageView.anchor(top: contentView.topAnchor,
                             left: currentDayLabel.rightAnchor,
                             bottom: contentView.bottomAnchor,
                             right: nil,
                             paddingTop: 8,
                             paddingLeft: 8,
                             paddingBottom: 8,
                             paddingRight: 0,
                             width: 0, height: 0)
        descriptionLabel.anchor(top: contentView.topAnchor,
                            left: curImageImageView.rightAnchor,
                            bottom: contentView.bottomAnchor,
                            right: contentView.rightAnchor,
                            paddingTop: 8,
                            paddingLeft: 8,
                            paddingBottom: 8,
                            paddingRight: 8,
                            width: 0, height: 0)
    }
    
    func configureCell(day: Int, minTemp: Double, maxTemp: Double, image: UIImage, description: String) {
        currentDayLabel.text = "\(day)"
        minTempLabel.text = "\(minTemp)"
        maxTempLabel.text = "\(maxTemp)"
        curImageImageView.image = image
        descriptionLabel.text = description
    }

}
