//
//  CustomAnimatedButton.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.10.2023.
//

import UIKit

struct ButtonCallBackModel {
    var id: Int?
    var name: String?
}

protocol CustomAnimatedButtonDelegate: AnyObject {
    func continueButton(model: ButtonCallBackModel)
}

final class CustomAnimatedButton: UIButton {
    
    // MARK: - Public properties
    
    weak var delegate: CustomAnimatedButtonDelegate?
    
    // MARK: - Private properties
    
    
    // Время анимации кнопки продолжить
    private let continueButtonAnimation = 0.11
    // размер изменения
    private let scaleSize: CGFloat = 0.93
    // id
    private var idButton: Int = 0
    // Имя кнопки
    private var nameButton: String = ""
    
    // границы кнопки для отслеживания touchesEnd
    private var buttonBounds: CGRect!
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper functions
    
    func setupId(id: Int) {
        idButton = id
    }
    
    func setuId(name: String) {
        nameButton = name
    }
    
    // Анимация завершения аминирования кнопки
    private func animationEnded(_ touches: Set<UITouch>, canceling: Bool = false, end: Bool = false) {
        // Анимируем в исходное состояние кнопку
        UIView.animate(withDuration: continueButtonAnimation, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            // Возвращаяем в начальное значение цвет кнопки
            self.transform = CGAffineTransform.identity
            
            // после завершения анимации выполняем переход через делегат
        } completion: { [weak self] success in
            guard let self = self else { return }
            // Выполняем делегат и восстанавливаем цвет кнопки в начальный
            if success {
                if self.buttonBounds.contains((touches.first?.location(in: self))!) {
                    let sendModel = ButtonCallBackModel(id: self.idButton,
                                                        name: nil)
                    self.delegate?.continueButton(model: sendModel)
                }
            }
        }
    }
    
    // MARK: - Actions
    
    //    когда отпускаем кнопку надо проверить на отпуск в кнопке или за пределами, если за пределами - ничего не происходит.
    //    когда отпустили сработала анимация, потом вернулась в исходное попложение и произошел переход
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // созранение текучих рамок кнопки
        buttonBounds = touches.first?.view?.bounds ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        
        // Анимация
        UIView.animate(withDuration: continueButtonAnimation, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.transform = CGAffineTransform(scaleX: scaleSize, y: scaleSize)
        } completion: { success in
            if success {
                self.animationEnded(touches)
            }
        }
    }
    
    // При отменене вызываем завершение анимации и выполняем делегат
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        animationEnded(touches, canceling: true)
    }
    
}

