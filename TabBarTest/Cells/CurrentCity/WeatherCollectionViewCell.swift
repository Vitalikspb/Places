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
        view.backgroundColor = .clear
        return view
    }()
    private let topContainerView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .setCustomColor(color: .weatherBlueBackground)
        return view
    }()
    private let buttonContainerView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .setCustomColor(color: .weatherBlueBackground)
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .bold, andSize: 20)
        label.text = Constants.Cells.weather
        return label
    }()
    private let todayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .setCustomFont(name: .regular, andSize: 14)
        label.text = Constants.Cells.today
        return label
    }()
    
    
    private let curTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 32)
        label.text = ""
        return label
    }()
    private let lightSmallRectangleView: UIView = {
       let view = UIView()
        view.backgroundColor = .setCustomColor(color: .weatherLightRectangle)
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor.setCustomColor(color: .weatherLightRectangleBorder).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    private let curImageLabel: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleToFill
        return image
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .setCustomFont(name: .regular, andSize: 14)
        label.text = ""
        return label
    }()
    private let tempFeelsLikeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .setCustomFont(name: .regular, andSize: 14)
        label.text = Constants.Cells.weatherFellsLike
        return label
    }()
    
   
    private let sunriseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .setCustomFont(name: .regular, andSize: 14)
        label.text = Constants.Cells.sunrise
        return label
    }()
   
    private let sunsetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = .setCustomFont(name: .regular, andSize: 14)
        label.text = Constants.Cells.sunset
        return label
    }()
   
    let fullWeatherButtons: UILabel = {
       let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        label.text = "Погода на 7 дней"
        label.textAlignment = .center
        return label
    }()
    
    private let favouriteButton: CustomAnimatedButton = {
        let button = CustomAnimatedButton()
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
        mainView.backgroundColor = .clear
        favouriteButton.delegate = self
        
        contentView.addSubviews(mainView)
        mainView.addSubviews(titleLabel, topContainerView, favouriteButton)
        topContainerView.addSubviews(todayLabel, lightSmallRectangleView, curTempLabel,
                                     tempFeelsLikeLabel, sunriseLabel, sunsetLabel)
        lightSmallRectangleView.addSubviews(curImageLabel)
        favouriteButton.addSubviews(buttonContainerView)
        buttonContainerView.addSubviews(fullWeatherButtons)
        
        mainView.addConstraintsToFillView(view: contentView)
        
        titleLabel.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: nil,
                          right: contentView.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 0, height: 32)
        
        topContainerView.anchor(top: titleLabel.bottomAnchor,
                                left: contentView.leftAnchor,
                                bottom: favouriteButton.topAnchor,
                                right: contentView.rightAnchor,
                                paddingTop: 16,
                                paddingLeft: 16,
                                paddingBottom: 8,
                                paddingRight: 16,
                                width: 0, height: 160)
        
        todayLabel.anchor(top: topContainerView.topAnchor,
                          left: topContainerView.leftAnchor,
                          bottom: nil,
                          right: topContainerView.rightAnchor,
                          paddingTop: 12,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 0, height: 24)
        lightSmallRectangleView.anchor(top: todayLabel.bottomAnchor,
                                       left: topContainerView.leftAnchor,
                                       bottom: nil,
                                       right: nil,
                                       paddingTop: 12,
                                       paddingLeft: 16,
                                       paddingBottom: 0,
                                       paddingRight: 0,
                                       width: 64,
                                       height: 64)
        curImageLabel.addConstraintsToFillView(view: lightSmallRectangleView)
        
        curTempLabel.anchor(top: todayLabel.bottomAnchor,
                            left: curImageLabel.rightAnchor,
                            bottom: nil,
                            right: nil,
                            paddingTop: 12,
                            paddingLeft: 12,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0,
                            height: 0)
        
        tempFeelsLikeLabel.anchor(top: curTempLabel.bottomAnchor,
                                  left: curImageLabel.rightAnchor,
                                  bottom: nil,
                                  right: topContainerView.rightAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 12,
                                  paddingBottom: 0,
                                  paddingRight: 16,
                                  width: 0,
                                  height: 0)
        
        sunriseLabel.anchor(top: curImageLabel.bottomAnchor,
                            left: topContainerView.leftAnchor,
                            bottom: topContainerView.bottomAnchor,
                            right: nil,
                            paddingTop: 12,
                            paddingLeft: 24,
                            paddingBottom: 16,
                            paddingRight: 0,
                            width: 0, height: 18)
        sunsetLabel.anchor(top: curImageLabel.bottomAnchor,
                           left: nil,
                           bottom: topContainerView.bottomAnchor,
                           right: topContainerView.rightAnchor,
                           paddingTop: 12,
                           paddingLeft: 0,
                           paddingBottom: 16,
                           paddingRight: 24,
                           width: 0, height: 18)
        favouriteButton.anchor(top: nil,
                                   left: contentView.leftAnchor,
                                   bottom: contentView.bottomAnchor,
                                   right: contentView.rightAnchor,
                                   paddingTop: 0,
                                   paddingLeft: 16,
                                   paddingBottom: 0,
                                   paddingRight: 16,
                                   width: 0, height: 40)
        buttonContainerView.addConstraintsToFillView(view: favouriteButton)
        fullWeatherButtons.addConstraintsToFillView(view: buttonContainerView)
    }
    
    func configureCell(city: String, curTemp: Int, curImage: UIImage, description: String, feelLike: Int, sunrise: Int,  sunset: Int) {
        todayLabel.text = "\(city) \(TimeFormatter.todayDayLetterFullFormat())"
        curTempLabel.text = "\(curTemp)ºC"
        curImageLabel.image = curImage
        descriptionLabel.text = "\(description)"
        tempFeelsLikeLabel.text = "Ощущается как: \(feelLike)ºC"
        TimeFormatter.utcToLocalTime(dateStr: "\(sunrise)", complection: { sunriseString in
            sunriseLabel.text = "\(Constants.Cells.sunrise) \(sunriseString)"
        })
        TimeFormatter.utcToLocalTime(dateStr: "\(sunset)", complection: { sunsetString in
            sunsetLabel.text = "\(Constants.Cells.sunset) \(sunsetString)"
        })
    }

}

// MARK: - CustomAnimatedButtonDelegate

extension WeatherCollectionViewCell: CustomAnimatedButtonDelegate {
    func continueButton(model: ButtonCallBackModel) {
        delegate?.showFullWeather()
    }
    
}
