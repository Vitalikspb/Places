//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

class WeatherView: UIView {
    
    // MARK: - UI properties
    
    private let mainContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .setCustomColor(color: .weatherBlueBackground)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
   
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .center
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        label.text = ""
        return label
    }()
    
        // MARK: - Public propetries
    
    var weatherViewTemperature: String = "" {
        didSet {
            temperatureLabel.text = weatherViewTemperature
        }
    }
    var weatherViewImage: UIImage? {
        didSet {
            weatherImage.image = weatherViewImage
        }
    }
    
    // MARK: - Private properties
    
    private var timerRepeat: Bool = true
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(mainContainerView)
        mainContainerView.addSubview(weatherImage)
        mainContainerView.addSubview(temperatureLabel)
        
        self.frame = CGRect(x: 0, y: 0, width: 48, height: 40)
        mainContainerView.frame = CGRect(x: 0, y: 0, width: 48, height: 40)
        weatherImage.frame = CGRect(x: 8, y: 4, width: 32, height: 32)
        temperatureLabel.frame = CGRect(x: 52, y: 4, width: 32, height: 32)
        
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
            UIView.animate(withDuration: 1.8, animations: { [weak self] in
                guard let self = self else { return }
                self.weatherImage.frame.origin.x = -40
                self.temperatureLabel.frame.origin.x = 9
            })
            timerRepeat = false
        } else {
            UIView.animate(withDuration: 1.8, animations: { [weak self] in
                guard let self = self else { return }
                self.weatherImage.frame.origin.x = 9
                self.temperatureLabel.frame.origin.x = 52
            })
            timerRepeat = true
        }
    }
    
    func configure(withImage image: UIImage, andTemperature temperature: String) {
        weatherImage.image = image
        temperatureLabel.text = temperature
    }
}
