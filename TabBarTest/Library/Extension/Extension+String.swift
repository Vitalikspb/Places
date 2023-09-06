//
//  Extension+String.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 10.12.2021.
//

import UIKit

extension String {
    
    /// высчитываем высоту текста при заданной ширине экрана и размера шрифта
    func height(widthScreen: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: widthScreen, height: .greatestFiniteMagnitude)
        
        // считаем ограниченный прямоугольник
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        // округляем значение
        return ceil(size.height)
    }
}
