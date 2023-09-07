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
    
    weak var onMapdelegate: ScrollViewOnMapDelegate?
    weak var actionButtonDelegate: ActionButtonsScrollViewDelegate?
    
    // MARK: - Private properties
    
    private var isSelected: Bool = false
    
    // MARK: - UI properties
    
    let routeButton = FilterView(withName: Constants.Views.travelGuide)
    let addToFavouritesButton = FilterView(withName: Constants.Views.toFeatures)
    let callButton = FilterView(withName: Constants.Views.makeCall)
    let shareButton = FilterView(withName: Constants.Views.share)
    let siteButton = FilterView(withName: Constants.Views.toSite)
    
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
        self.backgroundColor = .setCustomColor(color: .filterbuttonFloatingScreen)
        self.isScrollEnabled = true
        self.isDirectionalLockEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        [routeButton, addToFavouritesButton, callButton,
         shareButton, siteButton].forEach {
            $0.layer.cornerRadius = 12
            $0.backgroundColor = .setCustomColor(color: .filterView)
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
        siteButton.addGestureRecognizer(tapSiteButton)
        
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
        
        let frameRoute = CGRect(x: 16,
                                y: 10,
                                width: routeButtonWidth,
                                height: 36)
        routeButton.frame = frameRoute
        
        let frameFavourites = CGRect(x: routeButtonWidth + 28,
                                     y: 10,
                                     width: addToFavouritesButtonWidth,
                                     height: 36)
        addToFavouritesButton.frame = frameFavourites
        
        let frameCall = CGRect(x: routeButtonWidth + addToFavouritesButtonWidth + 40,
                               y: 10,
                               width: callButtonWidth,
                               height: 36)
        callButton.frame = frameCall
        
        let frameShare = CGRect(x: routeButtonWidth + addToFavouritesButtonWidth + callButtonWidth + 52,
                                y: 10,
                                width: shareButtonWidth,
                                height: 36)
        shareButton.frame = frameShare
        
        let frameSite = CGRect(x: routeButtonWidth + addToFavouritesButtonWidth + callButtonWidth + shareButtonWidth + 64,
                               y: 10,
                               width: siteButtonWidth,
                               height: 36)
        siteButton.frame = frameSite
        
        self.contentSize = CGSize(width: routeButtonWidth + addToFavouritesButtonWidth + callButtonWidth + shareButtonWidth + siteButtonWidth + 76,
                                  height: self.frame.height)
    }
    
    
    
    
}


