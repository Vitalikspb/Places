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
    let interestingButton = FilterView(withName: Constants.Views.interesting)
    let faqButton = FilterView(withName: Constants.Views.faq)
    
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
        self.backgroundColor = .setCustomColor(color: .filterbuttonFloatingScreen)
        self.isScrollEnabled = true
        self.isDirectionalLockEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        [favouriteButton, interestingButton, faqButton].forEach {
            $0.layer.cornerRadius = 12
            $0.backgroundColor = .setCustomColor(color: .filterView)
        }
        
        let tapFavouriteButton = UITapGestureRecognizer(target: self, action: #selector(handleFavouriteButton))
        favouriteButton.addGestureRecognizer(tapFavouriteButton)
        let tapInterestingButton = UITapGestureRecognizer(target: self, action: #selector(handleInterestingButton))
        interestingButton.addGestureRecognizer(tapInterestingButton)
        let tapFaqButton = UITapGestureRecognizer(target: self, action: #selector(handleFaqButton))
        faqButton.addGestureRecognizer(tapFaqButton)
        
        addSubview(favouriteButton)
        addSubview(interestingButton)
        addSubview(faqButton)
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
        
        let frameFavourites = CGRect(x: routeButtonWidth + 28,
                                     y: 10,
                                     width: addToFavouritesButtonWidth,
                                     height: 36)
        interestingButton.frame = frameFavourites
        
        let frameCall = CGRect(x: routeButtonWidth + addToFavouritesButtonWidth + 40,
                               y: 10,
                               width: callButtonWidth,
                               height: 36)
        faqButton.frame = frameCall
        
        self.contentSize = CGSize(width: routeButtonWidth + addToFavouritesButtonWidth + callButtonWidth  + 52,
                                  height: self.frame.height)
    }
    
    
    
    
}


