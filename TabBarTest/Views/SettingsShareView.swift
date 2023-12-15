//
//  SettingsTableViewCell.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 15.12.2023.
//

import UIKit
import SnapKit

struct SettingCellModel {
    let image: String
    let name: String
}

class SettingsShareView: UIView {
    
    // MARK: - UI Properties

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .setCustomColor(color: .filterView)
        return view
    }()
    private let animateButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .setCustomColor(color: .filterView)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    let titleImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .setCustomColor(color: .titleText)
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        label.numberOfLines = 1
        return label
    }()
    
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

    private func addViews() {
        self.addSubviews(animateButton)
        animateButton.addSubviews(containerView)
        containerView.addSubviews(mainView)
        mainView.addSubviews(titleImageView, titleLabel)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        animateButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
        titleImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.height.width.equalTo(22)
            $0.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Helper functions
    
    func configute(data: SettingCellModel) {
        titleLabel.text = data.name
        titleImageView.image = UIImage(named: data.image)
    }
    
    func returnWidthView() -> CGFloat {
        return titleLabel.textWidth()+32
    }
}
