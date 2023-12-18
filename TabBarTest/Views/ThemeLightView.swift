//
//  ThemeLightView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 16.12.2023.
//

import UIKit
import SnapKit

struct ThemeLightViewModel {
    let image: String
    let name: String
}

protocol ThemeLightViewDelegate: AnyObject {
    func updateTheme(name: String)
}

class ThemeLightView: UIView {
    
    // MARK: - UI Properties

    private let animateButtonView: UIView = {
       let view = UIView()
        return view
    }()
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .setCustomColor(color: .titleText)
        imageView.image = UIImage(named: "themeWhite")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .setCustomColor(color: .titleText)
        label.backgroundColor = .clear
        label.font = .setCustomFont(name: .regular, andSize: 14)
        label.numberOfLines = 1
        return label
    }()
    let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .setCustomColor(color: .titleText)
        imageView.image = UIImage(systemName: "checkmark.circle")
        imageView.contentMode = .center
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    
    // MARK: - Public properties
    
    var themeName: String = ""
    weak var delegate: ThemeLightViewDelegate?
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
        self.backgroundColor = .clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(updateTapped))
        animateButtonView.isUserInteractionEnabled = true
        animateButtonView.addGestureRecognizer(tap)
    }
    
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews() {
        self.addSubviews(mainView)
        mainView.addSubviews(titleImageView, titleLabel, checkImageView, animateButtonView)
    }
    
    private func addConstraints() {
        
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
        animateButtonView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        titleImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(180)
            $0.width.equalTo(90)
            $0.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(16)
        }
        checkImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(22)
        }
    }
    
    @objc func updateTapped() {
        delegate?.updateTheme(name: themeName)
    }
    
    // MARK: - Helper functions
    
    func configure(data: ThemeLightViewModel) {
        titleLabel.text = data.name
        themeName = data.name
        titleImageView.image = UIImage(named: data.image)
    }
    
    func isSelected(selected: Bool) {
        checkImageView.isHidden = !selected
    }
    
    func returnWidthView() -> CGFloat {
        return titleLabel.textWidth()+32
    }
}

