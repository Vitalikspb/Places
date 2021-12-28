//
//  CountryDescriptionTableViewCell.swift
//  TabBarTest
//
//

import UIKit
import CoreLocation

protocol WeatherCollectionViewCellDelegate: AnyObject {
    func showFullWeather()
}

class WeatherCollectionViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    private let mainView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 1.0/255, green: 1.0/255, blue: 1.0/255, alpha: 0.1)
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
        label.text = Constants.Cells.weather
        return label
    }()
    private let todayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = Constants.Cells.today
        return label
    }()
    private let curTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = ""
        return label
    }()
    private let curImageLabel: UIImageView = {
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
        label.text = ""
        return label
    }()
    private let tempFeelsLikeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = Constants.Cells.weatherFellsLike
        return label
    }()
    let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.axis = .horizontal
        return stack
    }()
    
    let sunriseStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 0
        stack.axis = .vertical
        return stack
    }()
    private let sunriseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = Constants.Cells.sunrise
        return label
    }()
    private let sunriseTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = "00:00"
        return label
    }()
    let sunsetStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 0
        stack.axis = .vertical
        return stack
    }()
    private let sunsetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = Constants.Cells.sunset
        return label
    }()
    private let sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans", size: 14)
        label.text = "00:00"
        return label
    }()
    let fullWeatherButtons: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "GillSans-semibold", size: 16)
        button.setTitle("Погода на 7 дней", for: .normal)
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    // MARK: -  Public Properties
    
    static let identifier = "WeatherCollectionViewCell"
    weak var delegate: WeatherCollectionViewCellDelegate?
    
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
        self.backgroundColor = .clear
        
        mainView.layer.cornerRadius = 10
        
        fullWeatherButtons.addTarget(self, action: #selector(fullWeatherTapped), for: .touchUpInside)
        
        contentView.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(todayLabel)
        mainView.addSubview(curTempLabel)
        mainView.addSubview(curImageLabel)
        mainView.addSubview(descriptionLabel)
        mainView.addSubview(tempFeelsLikeLabel)
        mainView.addSubview(mainStackView)
        mainView.addSubview(fullWeatherButtons)
        
        mainStackView.addArrangedSubview(sunriseStackView)
        mainStackView.addArrangedSubview(sunsetStackView)
        sunriseStackView.addArrangedSubview(sunriseLabel)
        sunriseStackView.addArrangedSubview(sunriseTimeLabel)
        sunsetStackView.addArrangedSubview(sunsetLabel)
        sunsetStackView.addArrangedSubview(sunsetTimeLabel)
        
        mainView.anchor(top: contentView.topAnchor,
                        left: contentView.leftAnchor,
                        bottom: contentView.bottomAnchor,
                        right: contentView.rightAnchor,
                        paddingTop: 10,
                        paddingLeft: 16,
                        paddingBottom: 0,
                        paddingRight: 16,
                        width: 0, height: 0)
        
        titleLabel.anchor(top: mainView.topAnchor,
                          left: mainView.leftAnchor,
                          bottom: nil,
                          right: mainView.rightAnchor,
                          paddingTop: 10,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0, height: 20)
        todayLabel.anchor(top: titleLabel.bottomAnchor,
                          left: mainView.leftAnchor,
                          bottom: nil,
                          right: curTempLabel.leftAnchor,
                          paddingTop: 8,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 8,
                          width: 0,
                          height: 25)
        curTempLabel.anchor(top: titleLabel.bottomAnchor,
                            left: nil,
                            bottom: nil,
                            right: curImageLabel.leftAnchor,
                            paddingTop: 8,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 8,
                            width: 0,
                            height: 25)
        curImageLabel.anchor(top: titleLabel.bottomAnchor,
                             left: nil,
                             bottom: nil,
                             right: nil,
                             paddingTop: 4,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 30,
                             height: 30)
        descriptionLabel.anchor(top: todayLabel.bottomAnchor,
                                left: mainView.leftAnchor,
                                bottom: nil,
                                right: mainView.rightAnchor,
                                paddingTop: 8,
                                paddingLeft: 16,
                                paddingBottom: 0,
                                paddingRight: 16,
                                width: 0,
                                height: 25)
        tempFeelsLikeLabel.anchor(top: descriptionLabel.bottomAnchor,
                                  left: mainView.leftAnchor,
                                  bottom: nil,
                                  right: mainView.rightAnchor,
                                  paddingTop: 8,
                                  paddingLeft: 16,
                                  paddingBottom: 0,
                                  paddingRight: 16,
                                  width: 0,
                                  height: 25)
        mainStackView.anchor(top: tempFeelsLikeLabel.bottomAnchor,
                             left: mainView.leftAnchor,
                             bottom: nil,
                             right: mainView.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 16,
                             paddingBottom: 0,
                             paddingRight: 16,
                             width: 0,
                             height: 50)
        fullWeatherButtons.anchor(top: mainStackView.bottomAnchor,
                                  left: mainView.leftAnchor,
                                  bottom: mainView.bottomAnchor,
                                  right: mainView.rightAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 16,
                                  paddingBottom: 10,
                                  paddingRight: 16,
                                  width: 0,
                                  height: 36)
    }
    
    func configureCell(city: String, curTemp: Int, curImage: UIImage, description: String, feelLike: Int, sunrise: Int,  sunset: Int) {
        titleLabel.text = Constants.Cells.weatherInCity + city
        curTempLabel.text = "\(curTemp)"
        curImageLabel.image = curImage
        descriptionLabel.text = "\(description)"
        tempFeelsLikeLabel.text = "Ощущается как: \(feelLike)"
        TimeFormatter.utcToLocalTime(dateStr: "\(sunrise)", complection: { sunriseString in
            sunriseTimeLabel.text = sunriseString
        })
        TimeFormatter.utcToLocalTime(dateStr: "\(sunset)", complection: { sunsetString in
            sunsetTimeLabel.text = sunsetString
        })
    }
    
    @objc func fullWeatherTapped() {
        delegate?.showFullWeather()
    }
    
}
