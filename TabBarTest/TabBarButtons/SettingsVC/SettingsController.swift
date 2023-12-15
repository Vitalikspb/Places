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
    
    private let themeColorView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .setCustomColor(color: .filterView)
        return view
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
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Helper functions
    
    private func setupUI() {
        self.view.addSubviews(themeColorView, shareButton, rateButton, helpButton)
        
        themeColorView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(160)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
        rateButton.snp.makeConstraints {
            $0.top.equalTo(themeColorView.snp.bottom).offset(16)
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
    
}
