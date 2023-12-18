//
//  NaviCheckRouteView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.12.2023.
//

import UIKit
import SnapKit

protocol NaviCheckRouteViewDelegate: AnyObject {
    func updateNaviRoute(name: String)
}

class NaviCheckRouteView: UIView {
    
    // MARK: - UI Properties

    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    let naviTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Построение маршрута через"
        label.textAlignment = .center
        label.textColor = .setCustomColor(color: .titleText)
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .bold, andSize: 17)
        label.numberOfLines = 1
        return label
    }()
    let naviCellsView: UIView = {
        let view = UIView()
        view.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    let naviSeparatorCellsView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    let yandexTapView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    let googleTapView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    let naviYandexCellLabel: UILabel = {
        let label = UILabel()
        label.text = "Яндекс"
        label.textAlignment = .center
        label.textColor = .setCustomColor(color: .titleText)
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .regular, andSize: 16)
        label.numberOfLines = 1
        return label
    }()
    let naviGoogleCellLabel: UILabel = {
        let label = UILabel()
        label.text = "Google"
        label.textAlignment = .center
        label.textColor = .setCustomColor(color: .titleText)
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .regular, andSize: 16)
        label.numberOfLines = 1
        return label
    }()
    let checkYandexImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .setCustomColor(color: .titleText)
        imageView.image = UIImage(systemName: "checkmark")
        imageView.contentMode = .center
        imageView.backgroundColor = .clear
        return imageView
    }()
    let checkGoogleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .setCustomColor(color: .titleText)
        imageView.image = UIImage(systemName: "checkmark")
        imageView.contentMode = .center
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    
    
    // MARK: - Public properties
    
    weak var delegate: NaviCheckRouteViewDelegate?
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    
    func configureNavi(selectedNavi name: String) {
        if name != "Google" {
            checkGoogleImageView.isHidden = true
            checkYandexImageView.isHidden = false
        } else {
            checkGoogleImageView.isHidden = false
            checkYandexImageView.isHidden = true
        }
    }

    private func addViews() {
        self.addSubviews(mainView)
        mainView.addSubviews(naviTitleLabel, naviCellsView)
        naviCellsView.addSubviews(naviYandexCellLabel, naviSeparatorCellsView, naviGoogleCellLabel, checkYandexImageView, checkGoogleImageView, yandexTapView, googleTapView)
        
        yandexTapView.isUserInteractionEnabled = true
        let yandexTap = UITapGestureRecognizer(target: self, action: #selector(yandexTaped))
        yandexTapView.addGestureRecognizer(yandexTap)
        
        googleTapView.isUserInteractionEnabled = true
        let googleTap = UITapGestureRecognizer(target: self, action: #selector(googleTaped))
        googleTapView.addGestureRecognizer(googleTap)
    }
    
    private func addConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        naviTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
            $0.height.equalTo(20)
        }
        naviCellsView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(naviTitleLabel.snp.bottom).offset(16)
            $0.height.equalTo(90)
        }
        yandexTapView.snp.makeConstraints {
            $0.top.equalTo(naviCellsView.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        googleTapView.snp.makeConstraints {
            $0.bottom.equalTo(naviCellsView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        naviYandexCellLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.height.equalTo(16)
            $0.leading.equalToSuperview().offset(16)
        }
        naviSeparatorCellsView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        naviGoogleCellLabel.snp.makeConstraints {
            $0.top.equalTo(naviSeparatorCellsView.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(16)
        }
        checkGoogleImageView.snp.makeConstraints {
            $0.centerY.equalTo(naviGoogleCellLabel.snp.centerY).offset(1)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(30)
        }
        checkYandexImageView.snp.makeConstraints {
            $0.centerY.equalTo(naviYandexCellLabel.snp.centerY).offset(1)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(30)
        }
    }
    
    // MARK: - Selectors
    
    @objc private func yandexTaped() {
        delegate?.updateNaviRoute(name: "Яндекс")
    }
    
    @objc private func googleTaped() {
        delegate?.updateNaviRoute(name: "Google")
    }
}
