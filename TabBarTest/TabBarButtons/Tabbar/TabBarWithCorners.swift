//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import Foundation
import UIKit

class TabBarWithCorners: UITabBar {
    
    private var color: UIColor?
    private var radii: CGFloat = 16.0
    private var shapeLayer: CALayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        var tabFrame = self.frame
        tabFrame.size.height = 55 + (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? CGFloat.zero)
        tabFrame.origin.y = self.frame.origin.y + ( self.frame.height - 55 - (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? CGFloat.zero))
        self.layer.cornerRadius = 16
        self.frame = tabFrame
        self.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0) })
    }
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.white.withAlphaComponent(0.1).cgColor
        shapeLayer.fillColor = UIColor.setCustomColor(color: .tabBarIconBackground).cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowOpacity = 0.05
        shapeLayer.shadowRadius = 16
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
        self.tintColor = .setCustomColor(color: .tabBarIconSelected)
        self.unselectedItemTintColor = .setCustomColor(color: .tabBarIconUnselected)
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: radii, height: 0.0))
        
        return path.cgPath
    }
}
