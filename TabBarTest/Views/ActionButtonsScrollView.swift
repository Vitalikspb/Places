//
//  ActionButtonsScrollView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.10.2021.
//

import UIKit

protocol ActionButtonsScrollViewDelegate: AnyObject {
    func routeButtonTapped()
    func addToFavouritesButtonTapped()
    func callButtonTapped()
    func shareButtonTapped()
    func siteButtonTapped()
}

class ActionButtonsScrollView: UIScrollView {
    
    // MARK: - Public properties
    
    var onMapdelegate: ScrollViewOnMapDelegate?
    weak var actionButtonDelegate: ActionButtonsScrollViewDelegate?
    
    // MARK: - Private properties
    
    private var isSelected: Bool = false
    
    // MARK: - UI properties
    
     let routeButton = FilterView(withName: "Маршрут")
     let addToFavouritesButton = FilterView(withName: "В избранное")
     let callButton = FilterView(withName: "Позвонить")
     let shareButton = FilterView(withName: "Поделиться")
    let siteButton = FilterView(withName: "Сайт")
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors

    @objc func handleRouteButton() {
        actionButtonDelegate?.routeButtonTapped()
    }
    @objc func handleAddToFavouritesButton() {
        actionButtonDelegate?.addToFavouritesButtonTapped()
    }
    @objc func handleCallButton() {
        actionButtonDelegate?.callButtonTapped()
    }
    @objc func handleShareButton() {
        actionButtonDelegate?.shareButtonTapped()
    }
    @objc func handleSiteButton() {
        actionButtonDelegate?.siteButtonTapped()
    }
    // MARK: - Helper Functions
    
    private func setupUI() {
        
        self.backgroundColor = .white
        self.isScrollEnabled = true
        self.isDirectionalLockEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        [routeButton, addToFavouritesButton, callButton,
         shareButton, siteButton].forEach {
            $0.layer.cornerRadius = 18
            $0.backgroundColor = UIColor.white
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.systemBlue.cgColor
        }
        
        let tapRouteButton = UITapGestureRecognizer(target: self, action: #selector(handleRouteButton))
        routeButton.addGestureRecognizer(tapRouteButton)
        let tapFavouriteButton = UITapGestureRecognizer(target: self, action: #selector(handleAddToFavouritesButton))
        addToFavouritesButton.addGestureRecognizer(tapFavouriteButton)
        let tapCallButton = UITapGestureRecognizer(target: self, action: #selector(handleCallButton))
        callButton.addGestureRecognizer(tapCallButton)
        let tapShareButton = UITapGestureRecognizer(target: self, action: #selector(handleShareButton))
        shareButton.addGestureRecognizer(tapShareButton)
        let tapSiteButton = UITapGestureRecognizer(target: self, action: #selector(handleSiteButton))
        shareButton.addGestureRecognizer(tapSiteButton)
        
        addSubview(routeButton)
        addSubview(addToFavouritesButton)
        addSubview(callButton)
        addSubview(shareButton)
        addSubview(siteButton)
        updateFullWidth()
    }
    
    func updateFullWidth() {
        let routeButtonWidth = routeButton.frame.width
        let addToFavouritesButtonWidth = addToFavouritesButton.frame.width
        let callButtonWidth = callButton.frame.width
        let shareButtonWidth = shareButton.frame.width
        let siteButtonWidth = siteButton.frame.width
        
        let frameRoute = CGRect(x: 12,
                                 y: 6,
                                 width: routeButtonWidth,
                                 height: 36)
        routeButton.frame = frameRoute
        
        let frameFavourites = CGRect(x: routeButtonWidth + 24,
                                y: 6,
                                width: addToFavouritesButtonWidth,
                                height: 36)
        addToFavouritesButton.frame = frameFavourites
        
        let frameCall = CGRect(x: routeButtonWidth + addToFavouritesButtonWidth + 36,
                                    y: 6,
                                    width: callButtonWidth,
                                    height: 36)
        callButton.frame = frameCall
        
        let frameShare = CGRect(x: routeButtonWidth + addToFavouritesButtonWidth + callButtonWidth + 48,
                                  y: 6,
                                  width: shareButtonWidth,
                                  height: 36)
        shareButton.frame = frameShare
        
        let frameSite = CGRect(x: routeButtonWidth + addToFavouritesButtonWidth + callButtonWidth + siteButtonWidth + 60,
                                  y: 6,
                                  width: shareButtonWidth,
                                  height: 36)
        siteButton.frame = frameSite
    
        self.contentSize = CGSize(width: routeButtonWidth + addToFavouritesButtonWidth + callButtonWidth + shareButtonWidth + siteButtonWidth + 72,
                                  height: self.frame.height)
    }
    
    
    
    
}


