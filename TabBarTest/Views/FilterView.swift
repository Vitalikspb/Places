//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

class FilterView: UIView {
    
    // MARK: - UI properties
    
    let myImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .setCustomColor(color: .titleText)
        return image
    }()
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Semibold", size: 16)
        return label
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(withName title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = .setCustomColor(color: .filterView)
        self.layer.cornerRadius = 12
        self.isUserInteractionEnabled = true
        
        label.text = title
        label.frame = CGRect(x: 10,
                             y: 0,
                             width: label.textWidth()+20,
                             height: 36)
        self.addSubview(label)
        self.frame = CGRect(x: 0,
                            y: 0,
                            width: label.frame.width,
                            height: 36)
    }
    
    init(withName title: String, andImage image: UIImage) {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 12
        self.isUserInteractionEnabled = true

        if title == "Поиск" || title == "Search" {
            myImage.image = image
            self.addSubview(myImage)
            myImage.frame = CGRect(x: 12,
                                   y: 8,
                                   width: 24,
                                   height: 24)
            self.frame = CGRect(x: 0,
                                y: 0,
                                width: myImage.frame.width+24,
                                height: 40)
        } else {
            myImage.image = image
            label.text = title
            self.addSubview(myImage)
            self.addSubview(label)
            myImage.frame = CGRect(x: 12,
                                   y: 8,
                                   width: 23,
                                   height: 23)
            label.frame = CGRect(x: CGFloat(myImage.frame.width) + 24,
                                 y: 0,
                                 width: label.textWidth() + 24,
                                 height: 40)
            self.frame = CGRect(x: 0, y: 0,
                                width: myImage.frame.width + label.frame.width+12,
                                height: 40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
