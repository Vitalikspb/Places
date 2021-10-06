//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol TopSearchViewDelegate {
    func clearTextField()
//    var textOfSearchTextField: String { set }
}

class TopSearchView: UIView {
    
    private let titleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "magnifyingglass")
        return image
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Поиск"
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        textField.isUserInteractionEnabled = true
        textField.text = ""
        return textField
    }()
    
    var topSearchDelegate: TopSearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.isUserInteractionEnabled = true
        self.backgroundColor = .white
        self.layer.cornerRadius = 30
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.60
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 2
        
        self.addSubview(titleImage)
        self.addSubview(inputTextField)
        inputTextField.addTarget(self, action: #selector(didtapped), for: .touchUpInside)
        inputTextField.delegate = self
        
        titleImage.frame = CGRect(x: 8,
                                  y: (self.frame.height / 2) - 14,
                                  width: 30,
                                  height: 30)
        inputTextField.frame = CGRect(x: CGFloat(titleImage.frame.width)+15,
                                      y: (self.frame.height / 2) - 18,
                                      width: UIScreen.main.bounds.width-76,
                                      height: 36)
    }
    
    @objc func didtapped() {
        inputTextField.becomeFirstResponder()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopSearchView: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("should clear")
        topSearchDelegate?.clearTextField()
        return true
    }
}
