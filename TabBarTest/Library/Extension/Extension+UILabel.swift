//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

extension UILabel {
    
    /// Возвращает ширину текста
    func textWidth() -> CGFloat {
        return UILabel.textWidth(label: self)
    }
    
    /// Возвращает вирину текста лейбла
    class func textWidth(label: UILabel) -> CGFloat {
        return textWidth(label: label, text: label.text ?? "")
    }
    
    /// Возвращает вирину текста лейбла и текста
    class func textWidth(label: UILabel, text: String) -> CGFloat {
        return textWidth(font: label.font, text: text)
    }
    
    /// Возвращает вирину текста в зависимости от шрифта и текста
    class func textWidth(font: UIFont, text: String) -> CGFloat {
        let myText = text as NSString
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude,
                          height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return ceil(labelSize.width)
    }
    
}
