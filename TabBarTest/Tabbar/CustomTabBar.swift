//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import Foundation
import UIKit

class CustomTaBarVC: UITabBarController, UITabBarControllerDelegate {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.selectedIndex = 0
//        setupTabBarButtons()
    }
    func setupTabBarButtons() {
        
        let firstButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 3)-92,
                                                 y: 5,
                                                 width: 46,
                                                 height: 30))
        firstButton.setBackgroundImage(UIImage.init(systemName: "terminal"), for: .normal)
        firstButton.tintColor = .blue
        firstButton.layer.shadowColor = UIColor.black.cgColor
        firstButton.layer.shadowOpacity = 0.1
        firstButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 3)*2-92,
                                                  y: 5,
                                                  width: 46,
                                                  height: 30))
        middleButton.setBackgroundImage(UIImage.init(systemName: "mail"), for: .normal)
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.1
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        let thirdButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 3)*3-92,
                                                 y: 5,
                                                 width: 46,
                                                 height: 30))
        thirdButton.setBackgroundImage(UIImage.init(systemName: "bookmark"), for: .normal)
        thirdButton.layer.shadowColor = UIColor.black.cgColor
        thirdButton.layer.shadowOpacity = 0.1
        thirdButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        self.tabBar.addSubview(firstButton)
        self.tabBar.addSubview(middleButton)
        self.tabBar.addSubview(thirdButton)
        
        firstButton.addTarget(self, action: #selector(firstButtonAction(sender:)), for: .touchUpInside)
        middleButton.addTarget(self, action: #selector(secondButtonAction(sender:)), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(thirdButtonAction(sender:)), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    @objc func firstButtonAction(sender: UIButton) {
        self.selectedIndex = 0
        sender.setBackgroundImage(UIImage.init(systemName: "sunrise"), for: .normal)
        sender.tintColor = .blue
        self.view.layoutIfNeeded()
    }
    @objc func secondButtonAction(sender: UIButton) {
        self.selectedIndex = 1
    }
    @objc func thirdButtonAction(sender: UIButton) {
        self.selectedIndex = 2
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            print("first button")
        case 1:
            print("second button")
        case 2:
            print("third button")
        default:
            break
        }
    }
}




