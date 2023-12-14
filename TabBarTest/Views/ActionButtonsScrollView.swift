//
//  ActionButtonsScrollView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.10.2021.
//

import UIKit
import CoreLocation

protocol ActionButtonsScrollViewDelegate: AnyObject {
    func routeButtonTapped(location: CLLocationCoordinate2D)
    func addToFavouritesButtonTapped(name: String)
    func callButtonTapped(withNumber: String)
    func siteButtonTapped(urlString: String)
}

class ActionButtonsScrollView: UIScrollView {
    
    // MARK: - Public properties
    
    weak var actionButtonDelegate: ActionButtonsScrollViewDelegate?
    
    // MARK: - Private properties
    
    private var isSelected: Bool = false
    
    // MARK: - UI properties
    
    let routeButton = FilterView(withName: Constants.Views.travelGuide)
    private let animateRouteButton: CustomAnimatedButton = {
        let button = CustomAnimatedButton()
        button.setupId(id: 0)
        return button
    }()
    
    let addToFavouritesButton = FilterView(withName: Constants.Views.toFeatures)
    private let animateAddToFavouritesButton: CustomAnimatedButton = {
        let button = CustomAnimatedButton()
        button.setupId(id: 1)
        return button
    }()
    
    let callButton = FilterView(withName: Constants.Views.makeCall)
    private let animateCallButton: CustomAnimatedButton = {
        let button = CustomAnimatedButton()
        button.setupId(id: 2)
        return button
    }()
    
    let siteButton = FilterView(withName: Constants.Views.toSite)
    private let animateSiteButton: CustomAnimatedButton = {
        let button = CustomAnimatedButton()
        button.setupId(id: 3)
        return button
    }()
    
    private var sight: Sight?
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    func setupFavoriteName(sight: Sight) {
        self.sight = sight
    }
    
    private func setupUI() {
        [animateRouteButton, animateAddToFavouritesButton,
         animateCallButton, animateSiteButton].forEach {
            $0.delegate = self
        }
        
        self.backgroundColor = .setCustomColor(color: .filterbuttonFloatingScreen)
        self.isScrollEnabled = true
        self.isDirectionalLockEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        [routeButton, addToFavouritesButton, callButton, siteButton].forEach {
            $0.layer.cornerRadius = 12
            $0.backgroundColor = .setCustomColor(color: .filterView)
        }
        animateRouteButton.addSubviews(routeButton)
        routeButton.addConstraintsToFillView(view: animateRouteButton)
        addSubview(animateRouteButton)
        
        animateAddToFavouritesButton.addSubviews(addToFavouritesButton)
        addToFavouritesButton.addConstraintsToFillView(view: animateAddToFavouritesButton)
        addSubview(animateAddToFavouritesButton)
        
        animateCallButton.addSubviews(callButton)
        callButton.addConstraintsToFillView(view: animateCallButton)
        addSubview(animateCallButton)
        
        animateSiteButton.addSubviews(siteButton)
        siteButton.addConstraintsToFillView(view: animateSiteButton)
        addSubview(animateSiteButton)
 
        updateFullWidth()
    }
    
    func updateFullWidth() {
        let routeButtonWidth = routeButton.frame.width
        let addToFavouritesButtonWidth = addToFavouritesButton.frame.width
        let callButtonWidth = callButton.frame.width
        let siteButtonWidth = siteButton.frame.width
        
        let frameRoute = CGRect(x: 16,
                                y: 10,
                                width: routeButtonWidth,
                                height: 36)
        routeButton.frame = frameRoute
        animateRouteButton.frame = frameRoute
        
        let frameFavourites = CGRect(x: routeButtonWidth + 28,
                                     y: 10,
                                     width: addToFavouritesButtonWidth,
                                     height: 36)
        addToFavouritesButton.frame = frameFavourites
        animateAddToFavouritesButton.frame = frameFavourites
        
        let frameCall = CGRect(x: routeButtonWidth + addToFavouritesButtonWidth + 40,
                               y: 10,
                               width: callButtonWidth,
                               height: 36)
        callButton.frame = frameCall
        animateCallButton.frame = frameCall
        
        let frameSite = CGRect(x: routeButtonWidth + addToFavouritesButtonWidth + callButtonWidth + 52,
                               y: 10,
                               width: siteButtonWidth,
                               height: 36)
        siteButton.frame = frameSite
        animateSiteButton.frame = frameSite
        
        let allWidth = routeButtonWidth + addToFavouritesButtonWidth +
        callButtonWidth + siteButtonWidth + 64
        self.contentSize = CGSize(width: allWidth,
                                  height: self.frame.height)
    }
    
    // Поиск
    @objc func handleRouteButton() {
        if let sight = sight {
            let location = CLLocationCoordinate2D(latitude: sight.latitude, longitude: sight.latitude)
            actionButtonDelegate?.routeButtonTapped(location: location)
        }
    }
    
    // Избранное
    @objc func handleAddToFavouritesButton() {
        if let name = sight?.name {
            actionButtonDelegate?.addToFavouritesButtonTapped(name: name)
        }
    }
    
    // Достопримечательность
    @objc func handleCallButton() {
        if let phone = sight?.main_phone {
            actionButtonDelegate?.callButtonTapped(withNumber: phone)
        }
    }
    
    // Музей
    @objc func handleSiteButton() {
        if let site = sight?.site {
            actionButtonDelegate?.siteButtonTapped(urlString: site)
        }
    }
}

// MARK: - CustomAnimatedButtonDelegate

extension ActionButtonsScrollView: CustomAnimatedButtonDelegate {
    
    func continueButton(id: Int) {
        switch id {
        case 0:
            handleRouteButton()
            
        case 1:
            handleAddToFavouritesButton()
            
        case 2:
            handleCallButton()
            
        case 3:
            handleSiteButton()
            
        default: break
        }
    }
    
}

