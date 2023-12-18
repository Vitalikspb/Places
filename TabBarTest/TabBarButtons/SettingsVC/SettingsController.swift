//
//  SettingsController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 14.10.2021.
//

import UIKit
import SnapKit


class SettingsController: UIViewController {

    // MARK: - UI Properties
    
//    private let themeColorView: UIView = {
//       let view = UIView()
//        return view
//    }()
    private let systemThemeImageView: ThemeLightView = {
       let button = ThemeLightView()
        button.configure(data: ThemeLightViewModel(image: "themeSystem", name: "Системная"))
        return button
    }()
    private let blackThemeImageView: ThemeLightView = {
       let button = ThemeLightView()
        button.configure(data: ThemeLightViewModel(image: "themeBlack", name: "Темная"))
        return button
    }()
    private let whiteThemeImageView: ThemeLightView = {
       let button = ThemeLightView()
        button.configure(data: ThemeLightViewModel(image: "themeWhite", name: "Светлая"))
        return button
    }()
    private let shareButton: SettingsShareView = {
       let button = SettingsShareView()
        button.configute(data: SettingCellModel(image: "square.and.arrow.up", name: "Поделиться"))
        return button
    }()
    private let rateButton: SettingsShareView = {
       let button = SettingsShareView()
        button.configute(data: SettingCellModel(image: "star", name: "Оценить"))
        return button
    }()
    private let helpButton: SettingsShareView = {
       let button = SettingsShareView()
        button.configute(data: SettingCellModel(image: "envelope.fill", name: "Поддержка"))
        return button
    }()
    private let naviCheckRouteView: NaviCheckRouteView = {
        let view = NaviCheckRouteView()
        return view
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Helper functions
    
    
    @objc func asd() {
        print("asd")
    }
    private func setupUI() {
        let themeName = UserDefaults.standard.string(forKey: UserDefaults.themeAppSelected) ?? "Системная"
        updateSelectedTheme(name: themeName)
        
        let naviName = UserDefaults.standard.string(forKey: UserDefaults.defaultNaviRoute) ?? "Google"
        updateNaviDefault(name: naviName)
        
        self.title = "Настройки"
        self.view.addSubviews(shareButton, rateButton, helpButton, naviCheckRouteView,
                              systemThemeImageView, blackThemeImageView, whiteThemeImageView)
        
        systemThemeImageView.snp.makeConstraints {
            $0.height.equalTo(230)
            $0.width.equalTo(110)
            $0.centerY.equalTo(blackThemeImageView.snp.centerY)
        }
        blackThemeImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(systemThemeImageView.snp.trailing).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(230)
            $0.width.equalTo(110)
        }
        whiteThemeImageView.snp.makeConstraints {
            $0.leading.equalTo(blackThemeImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(blackThemeImageView.snp.centerY)
            $0.height.equalTo(230)
            $0.width.equalTo(110)
        }
        
        rateButton.snp.makeConstraints {
            $0.top.equalTo(blackThemeImageView.snp.bottom).offset(16)
            $0.width.equalTo(rateButton.returnWidthView())
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(shareButton.snp.trailing).offset(8)
        }
        shareButton.snp.makeConstraints {
            $0.centerY.equalTo(rateButton.snp.centerY)
            $0.width.equalTo(shareButton.returnWidthView())
            $0.height.equalTo(80)
        }
        helpButton.snp.makeConstraints {
            $0.centerY.equalTo(rateButton.snp.centerY)
            $0.width.equalTo(helpButton.returnWidthView())
            $0.height.equalTo(80)
            $0.leading.equalTo(rateButton.snp.trailing).offset(8)
        }
        
        naviCheckRouteView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(helpButton.snp.bottom).offset(16)
            $0.height.equalTo(142)
        }
        
        naviCheckRouteView.delegate = self
        
        rateButton.isUserInteractionEnabled = true
        let rateTap = UITapGestureRecognizer(target: self, action: #selector(rateButtonTapped))
        rateButton.addGestureRecognizer(rateTap)
        
        shareButton.isUserInteractionEnabled = true
        let shareTap = UITapGestureRecognizer(target: self, action: #selector(shareButtonTapped))
        shareButton.addGestureRecognizer(shareTap)
        
        helpButton.isUserInteractionEnabled = true
        let helpTap = UITapGestureRecognizer(target: self, action: #selector(helpButtonTapped))
        helpButton.addGestureRecognizer(helpTap)
    }
    
    // MAKR: - Seledtors
    
    // Оценка в стор
    @objc private func rateButtonTapped() {
        guard let productURL = URL(string: Constants.shareLink) else { return }
        var components = URLComponents(url: productURL, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "action", value: "write-review")
        ]
        guard let writeReviewURL = components?.url else { return }
        UIApplication.shared.open(writeReviewURL)
    }
    
    // Поделиться с друзьями
    @objc private func shareButtonTapped() {
        let firstActivityItem = "Пригласить друзей"
        let secondActivityItem = Constants.shareLink
        let image: UIImage = UIImage(named: "AppIcon") ?? UIImage()
        let activityViewController: UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
        activityViewController.activityItemsConfiguration = [UIActivity.ActivityType.message] as? UIActivityItemsConfigurationReading
        
        // Убираем не нужные кнопки
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.dismiss(animated: true)
            }
        }
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // Написать в поддержку через форму гугла
    @objc private func helpButtonTapped() {
        let application = UIApplication.shared
        if let url = URL(string: Constants.support) {
            application.open(url)
        }
    }
    
    private func updateSelectedTheme(name: String) {
        UserDefaults.standard.set(name, forKey: UserDefaults.themeAppSelected)
        [systemThemeImageView, blackThemeImageView, whiteThemeImageView].forEach {
            let selected = $0.themeName == name ? true : false
            $0.isSelected(selected: name != "" ? selected : true)
            $0.delegate = self
        }
        updateThemeColor(withThemeName: name)
    }
    
    private func updateNaviDefault(name: String) {
        UserDefaults.standard.set(name, forKey: UserDefaults.defaultNaviRoute)
        naviCheckRouteView.configureNavi(selectedNavi: name)
    }
    
    func updateThemeColor(withThemeName name: String) {
        guard #available(iOS 13.0, *) else { return }
        switch name {
        case "Светлая":
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light }
            
        case "Темная":
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark }
            
        default:
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .unspecified }
        }
    }
    
}

// MARK: - NaviCheckRouteViewDelegate

extension SettingsController: NaviCheckRouteViewDelegate {
    
    func updateNaviRoute(name: String) {
        updateNaviDefault(name: name)
    }
    
}

// MARK: - ThemeLightViewDelegate

extension SettingsController: ThemeLightViewDelegate {
    
    func updateTheme(name: String) {
        updateSelectedTheme(name: name)
    }
    
}
