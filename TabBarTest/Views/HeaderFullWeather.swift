//
//  HeaderFullWeather.swift
//  TabBarTest
//
//

import UIKit

class HeaderFullWeather: UIView {
    
    // MARK: - UI properties
    
    
    private let mainContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .setCustomColor(color: .weatherBlueBackground)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .mainWhite)
        label.textAlignment = .center
        label.font = .setCustomFont(name: .bold, andSize: 16)
        label.text = ""
        return label
    }()
    
    private let lightSmallRectangleView: UIView = {
       let view = UIView()
        view.backgroundColor = .setCustomColor(color: .weatherLightRectangle)
        view.layer.cornerRadius = 32
        view.layer.borderColor = UIColor.setCustomColor(color: .weatherLightRectangleBorder).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    private let curImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let curTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .mainWhite)
        label.textAlignment = .center
        label.font = .setCustomFont(name: .bold, andSize: 24)
        label.text = ""
        return label
    }()
    
    private let tempFeelsLikeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .mainWhite)
        label.textAlignment = .center
        label.font = .setCustomFont(name: .regular, andSize: 14)
        label.text = ""
        return label
    }()
   
    private let sunriseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .mainWhite)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 14)
        label.text = Constants.Cells.sunrise
        return label
    }()

    private let sunsetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .mainWhite)
        label.textAlignment = .right
        label.font = .setCustomFont(name: .semibold, andSize: 14)
        label.text = Constants.Cells.sunset
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
        
        self.addSubviews(mainContainerView)
        mainContainerView.addSubviews(titleLabel, lightSmallRectangleView, sunriseLabel, sunsetLabel)
        lightSmallRectangleView.addSubviews(curImageView, curTempLabel, tempFeelsLikeLabel)

        mainContainerView.addConstraintsToFillView(view: self)
        
        titleLabel.centerX(inView: mainContainerView)
        titleLabel.anchor(top: mainContainerView.topAnchor,
                          left: mainContainerView.leftAnchor,
                          bottom: nil,
                          right: mainContainerView.rightAnchor,
                          paddingTop: 30,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 0,
                          height: 22)
        
        lightSmallRectangleView.centerX(inView: mainContainerView)
        lightSmallRectangleView.anchor(top: titleLabel.bottomAnchor,
                                       left: nil,
                                       bottom: nil,
                                       right: nil,
                                       paddingTop: 20,
                                       paddingLeft: 0,
                                       paddingBottom: 0,
                                       paddingRight: 0,
                                       width: 178,
                                       height: 178)
        
        
        curImageView.centerX(inView: lightSmallRectangleView)
        curImageView.anchor(top: lightSmallRectangleView.topAnchor,
                            left: nil,
                            bottom: nil,
                            right: nil,
                            paddingTop: 16,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 72,
                            height: 72)
        
        
        curTempLabel.centerX(inView: lightSmallRectangleView)
        curTempLabel.anchor(top: curImageView.bottomAnchor,
                            left: nil,
                            bottom: nil,
                            right: nil,
                            paddingTop: 16,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0,
                            height: 0)
        
        
        tempFeelsLikeLabel.centerX(inView: lightSmallRectangleView)
        tempFeelsLikeLabel.anchor(top: curTempLabel.bottomAnchor,
                                  left: nil,
                                  bottom: nil,
                                  right: nil,
                                  paddingTop: 6,
                                  paddingLeft: 0,
                                  paddingBottom: 0,
                                  paddingRight: 0,
                                  width: 0,
                                  height: 0)
        
        sunriseLabel.anchor(top: nil,
                            left: mainContainerView.leftAnchor,
                            bottom: mainContainerView.bottomAnchor,
                            right: nil,
                            paddingTop: 0,
                            paddingLeft: 32,
                            paddingBottom: 16,
                            paddingRight: 0,
                            width: 140,
                            height: 18)
        
        sunsetLabel.anchor(top: nil,
                           left: nil,
                           bottom: mainContainerView.bottomAnchor,
                           right: mainContainerView.rightAnchor,
                           paddingTop: 0,
                           paddingLeft: 0,
                           paddingBottom: 16,
                           paddingRight: 32,
                           width: 140,
                           height: 18)
    }
    
    func configureUI(title: String = "Weather", curTemp: String, curImage: UIImage, description: String, feelsLike: String, sunrise: String, sunset: String) {
        let today = TimeFormatter.todayDay()
        titleLabel.text = "\(description), \(today)".capitalizedSentence
        curTempLabel.text = "\(curTemp)\(Constants.unitCelcium)C".capitalizedSentence
        curImageView.image = curImage
        tempFeelsLikeLabel.text = "Ощущается как \(feelsLike)\(Constants.unitCelcium)C"
        TimeFormatter.utcToLocalTime(dateStr: "\(sunrise)", complection: { sunriseString in
            sunriseLabel.text = "\(Constants.Cells.sunrise) \(sunriseString)"
            
        })
        TimeFormatter.utcToLocalTime(dateStr: "\(sunset)", complection: { sunsetString in
            sunsetLabel.text = "\(Constants.Cells.sunset) \(sunsetString)"
        })
    
    }
}

