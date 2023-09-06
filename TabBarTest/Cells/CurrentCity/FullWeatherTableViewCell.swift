//
//  FullWeatherTableViewCell.swift
//  TabBarTest
//
//  Created by ViceCode on 21.12.2021.
//

import UIKit

class FullWeatherTableViewCell: UITableViewCell {
    
    // MARK: - UI Properties
    
    private let mainContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .setCustomColor(color: .weatherCellBackground)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let currentDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-bold", size: 14)
        label.text = ""
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
        label.textColor = .setCustomColor(color: .subTitleText)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = ""
        return label
    }()
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .weatherBlueText)
        label.textAlignment = .right
        label.font = UIFont.init(name: "GillSans-semiBold", size: 14)
        label.text = ""
        return label
    }()
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .weatherBlueText)
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-semiBold", size: 14)
        label.text = ""
        return label
    }()
    
    // MARK: - Public properties
    
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
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubviews(mainContainerView)
        mainContainerView.addSubviews(currentDayLabel, minTempLabel, maxTempLabel,
                                      curImageImageView, descriptionLabel)
        
        mainContainerView.anchor(top: contentView.topAnchor,
                                  left: contentView.leftAnchor,
                                  bottom: contentView.bottomAnchor,
                                  right: contentView.rightAnchor,
                                  paddingTop: 4,
                                  paddingLeft: 16,
                                  paddingBottom: 4,
                                  paddingRight: 16,
                                  width: 0, height: 0)
        
        currentDayLabel.centerY(inView: mainContainerView)
        currentDayLabel.anchor(top: nil,
                          left: mainContainerView.leftAnchor,
                          bottom: nil,
                          right: nil,
                          paddingTop: 0,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 100, height: 18)
        
        curImageImageView.centerY(inView: mainContainerView)
        curImageImageView.anchor(top: nil,
                             left: nil,
                             bottom: nil,
                             right: nil,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 28, height: 28)
        
        descriptionLabel.centerY(inView: mainContainerView)
        descriptionLabel.anchor(top: nil,
                            left: curImageImageView.rightAnchor,
                            bottom: nil,
                            right: minTempLabel.leftAnchor,
                            paddingTop: 0,
                            paddingLeft: 8,
                            paddingBottom: 0,
                            paddingRight: 16,
                            width: 110, height: 0)
        
        minTempLabel.centerY(inView: mainContainerView)
        minTempLabel.anchor(top: nil,
                             left: nil,
                             bottom: nil,
                             right: maxTempLabel.leftAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0, height: 18)
        
        maxTempLabel.centerY(inView: mainContainerView)
        maxTempLabel.anchor(top: nil,
                            left: nil,
                            bottom: nil,
                            right: mainContainerView.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 16,
                            width: 0, height: 18)
        
    }
    
    func configureCell(day: Int, minTemp: Int, maxTemp: Int, image: UIImage, description: String) {
        TimeFormatter.utcToLocalDate(dateStr: "\(day)", complection: { day in
            currentDayLabel.text = day.capitalizedSentence
        })
        minTempLabel.text = "\(minTemp) /"
        maxTempLabel.text = " \(maxTemp)\(Constants.unitCelcium)"
        curImageImageView.image = image
        descriptionLabel.text = description.capitalizedSentence
    }

}
