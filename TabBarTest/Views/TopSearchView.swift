//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol TopSearchViewDelegate: AnyObject {
    func clearTextField()
    func findSight(withCharacter: String)
}

class TopSearchView: UIView {
    
    // MARK: - UI properties
    
    private let titleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "search")
        image.tintColor = .setCustomColor(color: .titleText)
        return image
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.Views.search
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        textField.isUserInteractionEnabled = true
        textField.text = ""
        textField.textColor = .setCustomColor(color: .titleText)
        return textField
    }()
    
    // MARK: - Public properties
    
    weak var topSearchDelegate: TopSearchViewDelegate?
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.backgroundColor = .setCustomColor(color: .tabBarIconBackground)
        self.layer.cornerRadius = 12
        
        self.addSubview(titleImage)
        self.addSubview(inputTextField)
        
        inputTextField.addTarget(self, action: #selector(didtapped), for: .touchUpInside)
        inputTextField.delegate = self
        
        titleImage.frame = CGRect(x: 12,
                                  y: (self.frame.height / 2) - 14,
                                  width: 30,
                                  height: 30)
        inputTextField.frame = CGRect(x: CGFloat(titleImage.frame.width) + 22,
                                      y: (self.frame.height / 2) - 18,
                                      width: UIScreen.main.bounds.width - (CGFloat(titleImage.frame.width) + 24) - 40,
                                      height: 36)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func didtapped() {
        inputTextField.becomeFirstResponder()
    }
}

// MARK: - UITextFieldDelegate

extension TopSearchView: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        topSearchDelegate?.clearTextField()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        topSearchDelegate?.findSight(withCharacter: textField.text ?? "")
    }
    
}
