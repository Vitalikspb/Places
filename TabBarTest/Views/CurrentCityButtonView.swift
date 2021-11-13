//
//  CurrentCityButtonView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol CurrentCityButtonViewDelegate: AnyObject {
    func showCurrentCityViewController()
}

class CurrentCityButtonView: UIView {
    
    weak var delegate: CurrentCityButtonViewDelegate?
    
    let showCurrentCityButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "vkontakte"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        return button
    }()
    
    var timerRepeat: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
        self.backgroundColor = .white
        self.layer.cornerRadius = 30
        
        self.standartShadow(view: self)
        
        self.addSubview(showCurrentCityButton)
        
        showCurrentCityButton.anchor(top: topAnchor,
                                     left: leftAnchor,
                                     bottom: bottomAnchor,
                                     right: rightAnchor,
                                     paddingTop: 0,
                                     paddingLeft: 0,
                                     paddingBottom: 0,
                                     paddingRight: 0,
                                     width: 0, height: 0)
        showCurrentCityButton.addTarget(self,
                                        action: #selector(showCurrentCityButtonTapped),
                                        for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showCurrentCityButtonTapped() {
        delegate?.showCurrentCityViewController()
    }
}
