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
        self.addSubview(todayLabel)
        self.addSubview(curTempLabel)
        self.addSubview(curImageLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(tempFeelsLikeLabel)
        self.addSubview(mainStackView)
        
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
        todayLabel.anchor(top: titleLabel.bottomAnchor,
                          left: self.leftAnchor,
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
                                left: self.leftAnchor,
                                bottom: nil,
                                right: self.rightAnchor,
                                paddingTop: 8,
                                paddingLeft: 16,
                                paddingBottom: 0,
                                paddingRight: 16,
                                width: 0,
                                height: 25)
        tempFeelsLikeLabel.anchor(top: descriptionLabel.bottomAnchor,
                                  left: self.leftAnchor,
                                  bottom: nil,
                                  right: self.rightAnchor,
                                  paddingTop: 8,
                                  paddingLeft: 16,
                                  paddingBottom: 0,
                                  paddingRight: 16,
                                  width: 0,
                                  height: 25)
        mainStackView.anchor(top: tempFeelsLikeLabel.bottomAnchor,
                             left: self.leftAnchor,
                             bottom: nil,
                             right: self.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 16,
                             paddingBottom: 0,
                             paddingRight: 16,
                             width: 0,
                             height: 50)
    }
    
    func configureUI(title: String = "Weather", today: String, curTemp: String, curImage: UIImage, description: String, feelsLike: String, sunrise: String, sunset: String) {
        titleLabel.text = title
        todayLabel.text = today
        curTempLabel.text = curTemp
        curImageLabel.image = curImage
        descriptionLabel.text = description
        tempFeelsLikeLabel.text = feelsLike
        sunriseLabel.text = sunrise
        sunsetLabel.text = sunset
    }
}
