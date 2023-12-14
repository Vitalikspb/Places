//
//  ActionsButtonsCityView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 08.09.2023.
//

import UIKit

protocol ActionsButtonsCityViewDelegate: AnyObject {
    func favouriteButtonTapped()
    func interestingButtonTapped()
    func faqButtonTapped()
}

class ActionsButtonsCityView: UIScrollView {
    
    // MARK: - Public properties
    
    weak var actionButtonDelegate: ActionsButtonsCityViewDelegate?
    
    // MARK: - Private properties
    
    private var isSelected: Bool = false
    
    // MARK: - UI properties
    
    let favouriteButton = FilterView(withName: Constants.Views.favourite)
    private let animateFavouriteButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
        button.setupId(id: 0)
        return button
    }()
    
    let interestingButton = FilterView(withName: Constants.Views.interesting)
    private let animateInterestingButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
        button.setupId(id: 1)
        return button
    }()
    
    let faqButton = FilterView(withName: Constants.Views.faq)
    private let animateFaqButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
        button.setupId(id: 2)
        return button
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
//    @objc func handleFavouriteButton() {
//        animateButton() {
//            print("tap")
////            self.actionButtonDelegate?.favouriteButtonTapped()
//        }
//    }
//    @objc func handleInterestingButton() {
//        animateButton() {
//            self.actionButtonDelegate?.interestingButtonTapped()
//        }
//    }
//    @objc func handleFaqButton() {
//        animateButton() {
//            self.actionButtonDelegate?.faqButtonTapped()
//        }
//    }

    // MARK: - Helper Functions
    
    private func animateButton(completion: @escaping ()->()) {
        // анимация уменьшения
        UIView.animate(withDuration: 0.25) {
            self.transform = CGAffineTransform(scaleX: 0.93, y: 0.93)
        } completion: { success in
            if success {
                // по окончанию анимация увелицения
                UIView.animate(withDuration: 0.25) {
                    self.transform = CGAffineTransform(scaleX: 0.93, y: 0.93)
                } completion: { success in
                    if success {
                        // по окончанию выполнение нажатия
                        completion()
                    }
                }
                
            }
        }

    }
    
    private func setupUI() {
//        let tapanimateFavouriteButton = UITapGestureRecognizer(target: self, action: #selector(handleFavouriteButton))
//        animateFavouriteButton.addGestureRecognizer(tapanimateFavouriteButton)
//        animateFavouriteButton.isUserInteractionEnabled = true
        animateFavouriteButton.delegate = self
//        let tapanimateInterestingButton = UITapGestureRecognizer(target: self, action: #selector(handleInterestingButton))
//        animateInterestingButton.addGestureRecognizer(tapanimateInterestingButton)
//        animateInterestingButton.isUserInteractionEnabled = true
        animateInterestingButton.delegate = self
//        let tapaanimateFaqButton = UITapGestureRecognizer(target: self, action: #selector(handleFaqButton))
//        animateFaqButton.addGestureRecognizer(tapaanimateFaqButton)
//        animateFaqButton.isUserInteractionEnabled = true
        animateFaqButton.delegate = self
        
        self.backgroundColor = .setCustomColor(color: .filterbuttonFloatingScreen)
        self.isScrollEnabled = true
        self.isDirectionalLockEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        [favouriteButton, interestingButton, faqButton].forEach {
            $0.layer.cornerRadius = 12
            $0.backgroundColor = .setCustomColor(color: .filterView)
        }
        
        addSubview(animateFavouriteButton)
        animateFavouriteButton.addSubviews(favouriteButton)
        favouriteButton.addConstraintsToFillView(view: animateFavouriteButton)
        
        addSubview(animateInterestingButton)
        animateInterestingButton.addSubviews(interestingButton)
        interestingButton.addConstraintsToFillView(view: animateInterestingButton)
        
        addSubview(animateFaqButton)
        animateFaqButton.addSubviews(faqButton)
        faqButton.addConstraintsToFillView(view: animateFaqButton)

        updateFullWidth()
    }
    
    func updateFullWidth() {
        let routeButtonWidth = favouriteButton.frame.width
        let addToFavouritesButtonWidth = interestingButton.frame.width
        let callButtonWidth = faqButton.frame.width
        
        let frameRoute = CGRect(x: 16,
                                y: 10,
                                width: routeButtonWidth,
                                height: 36)
        favouriteButton.frame = frameRoute
        animateFavouriteButton.frame = frameRoute
        
        let frameFavourites = CGRect(x: routeButtonWidth + 28,
                                     y: 10,
                                     width: addToFavouritesButtonWidth,
                                     height: 36)
        interestingButton.frame = frameFavourites
        animateInterestingButton.frame = frameFavourites
        
        let frameCall = CGRect(x: routeButtonWidth + addToFavouritesButtonWidth + 40,
                               y: 10,
                               width: callButtonWidth,
                               height: 36)
        faqButton.frame = frameCall
        animateFaqButton.frame = frameCall
        
        self.contentSize = CGSize(width: routeButtonWidth + addToFavouritesButtonWidth + callButtonWidth  + 52,
                                  height: self.frame.height)
    }
    

}

// MARK: - CustomAnimatedButtonDelegate

extension ActionsButtonsCityView: CustomAnimatedButtonDelegate {
    
    func continueButton(id: Int) {
        switch id {
        case 0:
            self.actionButtonDelegate?.favouriteButtonTapped()
            
        case 1:
            self.actionButtonDelegate?.interestingButtonTapped()
            
        case 2:
            self.actionButtonDelegate?.faqButtonTapped()
            
        default: break
            
        }
    }
    
    
}



