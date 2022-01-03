//
//  HeaderFullWeather.swift
//  TabBarTest
//
//

import UIKit

class HeaderFullWeather: UIView {
    
    // MARK: - UI properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.init(name: "GillSans-Semibold", size: 22)
        label.text = Constants.Cells.weather
        return label
    }()
    private let curTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.init(name: "GillSans-Semibold", size: 26)
        label.text = ""
        return label
    }()
    private let curImageView: UIImageView = {
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
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.init(name: "GillSans", size: 18)
        label.text = ""
        return label
    }()
    private let tempFeelsLikeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
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
        label.text = "Рассвет"
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
        label.text = "Закат"
        return label
    }()
    private let separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Static function
    
    
    // MARK: - Helper functions
    
    private func setupUI() {
        self.backgroundColor = .clear
        
        self.addSubview(titleLabel)
        self.addSubview(curTempLabel)
        self.addSubview(curImageView)
        self.addSubview(descriptionLabel)
        self.addSubview(tempFeelsLikeLabel)
        self.addSubview(mainStackView)
        self.addSubview(separatorView)
        
        mainStackView.addArrangedSubview(sunriseStackView)
        mainStackView.addArrangedSubview(sunsetStackView)
        sunriseStackView.addArrangedSubview(sunriseLabel)
        sunriseStackView.addArrangedSubview(sunriseTimeLabel)
        sunsetStackView.addArrangedSubview(sunsetLabel)
        sunsetStackView.addArrangedSubview(sunsetTimeLabel)
        
        titleLabel.anchor(top: self.topAnchor,
                          left: self.leftAnchor,
                          bottom: nil,
                          right: self.rightAnchor,
                          paddingTop: 10,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0, height: 20)
        curTempLabel.centerX(inView: self)
        curTempLabel.anchor(top: titleLabel.bottomAnchor,
                             left: nil,
                             bottom: nil,
                             right: nil,
                             paddingTop: 4,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 100,
                             height: 50)

        curImageView.anchor(top: curTempLabel.bottomAnchor,
                            left: self.leftAnchor,
                             bottom: nil,
                             right: nil,
                             paddingTop: 0,
                             paddingLeft: 80,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 80,
                             height: 80)
        descriptionLabel.anchor(top: curImageView.topAnchor,
                                left: curImageView.rightAnchor,
                                bottom: nil,
                                right: self.rightAnchor,
                                paddingTop: 27,
                                paddingLeft: 8,
                                paddingBottom: 0,
                                paddingRight: 16,
                                width: 0,
                                height: 25)
        tempFeelsLikeLabel.anchor(top: curImageView.bottomAnchor,
                                  left: self.leftAnchor,
                                  bottom: nil,
                                  right: self.rightAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 16,
                                  paddingBottom: 0,
                                  paddingRight: 16,
                                  width: 0,
                                  height: 25)
        mainStackView.anchor(top: tempFeelsLikeLabel.bottomAnchor,
                             left: self.leftAnchor,
                             bottom: separatorView.topAnchor,
                             right: self.rightAnchor,
                             paddingTop: 4,
                             paddingLeft: 16,
                             paddingBottom: 2,
                             paddingRight: 16,
                             width: 0,
                             height: 50)
        separatorView.anchor(top: nil,
                             left: self.leftAnchor,
                             bottom: self.bottomAnchor,
                             right: self.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 16,
                             paddingBottom: 0,
                             paddingRight: 16,
                             width: 0,
                             height: 1)
    }
    
    func configureUI(title: String = "Weather", curTemp: String, curImage: UIImage, description: String, feelsLike: String, sunrise: String, sunset: String) {
        titleLabel.text = title
        curTempLabel.text = curTemp
        curImageView.image = curImage
        descriptionLabel.text = description
        tempFeelsLikeLabel.text = "Ощущается как \(feelsLike)"
        TimeFormatter.utcToLocalTime(dateStr: "\(sunrise)", complection: { sunriseString in
            sunriseTimeLabel.text = sunriseString
        })
        TimeFormatter.utcToLocalTime(dateStr: "\(sunset)", complection: { sunsetString in
            sunsetTimeLabel.text = sunsetString
        })
        
        var selfColor = UIColor()
        switch description {
        case "clear sky": selfColor = .yellow
        case "few clouds": selfColor = .blue
        case "few clouds1":  selfColor = .secondaryLabel
        case "scattered clouds": selfColor = .lightGray
        case "broken clouds": selfColor = .gray
        case "shower rain": selfColor = .darkGray
        case "rain": selfColor = .cyan
        case "thunderstorm": selfColor = .brown
        case "snow": selfColor = .white
        case "mist": selfColor = .magenta
        default: selfColor = .white
        }
        self.backgroundColor = selfColor
    }
}
