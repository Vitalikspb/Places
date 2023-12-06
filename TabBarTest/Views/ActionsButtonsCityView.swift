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
        return button
    }()
    
    let interestingButton = FilterView(withName: Constants.Views.interesting)
    private let animateInterestingButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
        return button
    }()
    
    let faqButton = FilterView(withName: Constants.Views.faq)
    private let animateFaqButton: CustomAnimatedButton = {
       let button = CustomAnimatedButton()
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
    
    @objc func handleFavouriteButton() {
        actionButtonDelegate?.favouriteButtonTapped()
    }
    @objc func handleInterestingButton() {
        actionButtonDelegate?.interestingButtonTapped()
    }
    @objc func handleFaqButton() {
        actionButtonDelegate?.faqButtonTapped()
    }

    // MARK: - Helper Functions
    
    private func setupUI() {
//        animateFavouriteButton.delegate = self
//        animateFavouriteButton.setupId(id: 0)
        
//        animateInterestingButton.delegate = self
//        animateInterestingButton.setupId(id: 1)
        
//        animateFaqButton.delegate = self
//        animateFaqButton.setupId(id: 2)
        
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
    
    func continueButton() {
//        switch model.id {
//            
//        case 0:
//            handleFavouriteButton()
//            
//        case 1:
//            handleInterestingButton()
//            
//        case 2:
//            handleFaqButton()
//            
//        default:
//            break
//        }
    }
    
    
}


