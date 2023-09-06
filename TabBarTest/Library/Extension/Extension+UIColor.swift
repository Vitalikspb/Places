//
//  Extension+UIColor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 06.09.2023.
//

import UIKit

extension UIColor {

    enum CustomColor: String {
        /// фон поиска
        case filterBackground = "filterBackground"
        /// фон фильтров
        case filterView = "filterView"
        /// сепаратор на всплывающих вьюхах
        case separatorAppearanceView = "lineAppearanceView"
        /// сепаратор на всплывающих вьюхах не меняющийся
        case separatorAppearanceViewNonChanged = "lineAppearanceViewNonChanged"
        
        /// серый основной
        case mainGray = "mainGray"
        /// основная темносерая вьюха
        case mainView = "mainView"
        /// основной белый
        case mainWhite = "mainWhite"
        /// основной текст саб текст
        case subTitleText = "subTitleText"
        /// иконки таббара выбранные
        case tabBarIconSelected = "tabBarIconSelected"
        /// иконки таббара невыбранные
        case tabBarIconUnselected = "tabBarIconUnselected"
        /// Основной текст
        case titleText = "titleText"
        /// красное предупреждение
        case warningRedLight = "warningRedLight"
        /// Синий фон на экране погоды
        case weatherBlueBackground = "weatherBlueBackground"
        /// Синий текст на экране погоды
        case weatherBlueText = "weatherBlueText"
        /// Светло синий квадрат на экране погоды
        case weatherLightRectangle = "weatherLightRectangle"
        /// Рамка квадрата погоды
        case weatherLightRectangleBorder = "weatherLightRectangleBorder"
        /// цвет ячеек в погоде
        case weatherCellBackground = "weatherCellBackground"
        /// цвет таблицы в погоде
        case weatherTableViewBackground = "weatherTableViewBackground"
        ///
        case filterViewMain = "filterViewMain"
        ///
        case filterViewMainSearch = "filterViewMainSearch"
    }
    
   static func setCustomColor(color: CustomColor) -> UIColor {
        return UIColor(named: color.rawValue) ?? .black
    }
    
}
