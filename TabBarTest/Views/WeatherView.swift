//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

class WeatherView: UIView {
    
    lazy var leftGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.white.withAlphaComponent(1.0).cgColor,
            UIColor.white.withAlphaComponent(0.0).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
    lazy var rightGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.white.withAlphaComponent(0.0).cgColor,
            UIColor.white.withAlphaComponent(1.0).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    var weatherViewImage: UIImage? {
        didSet {
            weatherImage.image = weatherViewImage
        }
    }
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1764705882, green: 0.2, blue: 0.2588235294, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = ""
        return label
    }()
    var weatherViewTemperature: String = "" {
        didSet {
            temperatureLabel.text = weatherViewTemperature
        }
    }
    private let shadowView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    
    var timerRepeat: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.60
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 2
        
        self.addSubview(shadowView)
        shadowView.addSubview(weatherImage)
        shadowView.addSubview(temperatureLabel)
        shadowView.layer.addSublayer(leftGradient)
        shadowView.layer.addSublayer(rightGradient)
        
        shadowView.frame = CGRect(x: 0, y: 0, width: 50, height: 38)
        leftGradient.frame = CGRect(x: 0, y: 0, width: 8, height: 38)
        rightGradient.frame = CGRect(x: 42, y: 0, width: 8, height: 38)
        weatherImage.frame = CGRect(x: 9, y: 3, width: 32, height: 32)
        temperatureLabel.frame = CGRect(x: 55, y: 3, width: 32, height: 32)
        let _ = Timer.scheduledTimer(timeInterval: 15.0,
                                     target: self,
                                     selector: #selector(repeatWeatherAnimate),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func repeatWeatherAnimate() {
        if timerRepeat {
            UIView.animate(withDuration: 1.8, animations: {
                self.weatherImage.frame.origin.x = -40
                self.temperatureLabel.frame.origin.x = 12
            })
            timerRepeat = false
        } else {
            UIView.animate(withDuration: 1.8, animations: {
                self.weatherImage.frame.origin.x = 9
                self.temperatureLabel.frame.origin.x = 55
            })
            timerRepeat = true
        }
    }
    
    func configure(withImage image: UIImage, andTemperature temperature: String) {
        weatherImage.image = image
        temperatureLabel.text = temperature
    }
}
