//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit



class FilterView: UIView {
    
    let myImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image?.withTintColor(.systemBlue)
        return image
    }()
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans", size: 17)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init(withName title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 18
        self.isUserInteractionEnabled = true
        
        label.text = title
        label.frame = CGRect(x: 10, y: 0,
                             width: label.textWidth()+20, height: 36)
        self.addSubview(label)
        self.frame = CGRect(x: 0, y: 0,
                            width: label.frame.width, height: 36)
    }
    
    init(withName title: String, andImage image: UIImage) {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 18
        self.isUserInteractionEnabled = true
        
        
        myImage.image = image
        label.text = title
        
        self.addSubview(myImage)
        self.addSubview(label)
        
        
        myImage.frame = CGRect(x: 8, y: 6,
                               width: 23, height: 23)
        label.frame = CGRect(x: CGFloat(myImage.frame.width) + 12, y: 0,
                             width: label.textWidth() + 18, height: 36)
        self.frame = CGRect(x: 0, y: 0,
                            width: myImage.frame.width + label.frame.width, height: 36)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
