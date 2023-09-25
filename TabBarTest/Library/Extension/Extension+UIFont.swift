//
//  Extension+UIFont.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 25.09.2023.
//

import Foundation
import UIKit

extension UIFont {
    
    // Шрифты которые используем в приложении
    enum CustomFontName: String {
        case regular = "GillSans-Regular"
        case bold = "GillSans-bold"
        case semibold = "GillSans-Semibold"
    }
    
    /// Устанавливаем шрифт SFProDisplay
    ///
    /// ```
    /// .setCustomFont(name: .regular, andSize: 12)
    /// // return UIFont(name: "GillSans-Regular", size: 12)
    /// ```
    /// Parameter subject:
    /// - CustomFontName: Regular, Semibold, Bold
    /// - size of font
    /// - Returns: return SFProDisplay font with size
    static func setCustomFont(name customFont: CustomFontName, andSize size: CGFloat) -> UIFont {
        return UIFont(name: customFont.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
