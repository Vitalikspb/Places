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
    private let animateRouteButton: UIView = {
        let button = UIView()
        return button
    }()
    
    let addToFavouritesButton = FilterView(withName: Constants.Views.toFeatures)
    private let animateAddToFavouritesButton: UIView = {
        let button = UIView()
        return button
    }()
    
    let callButton = FilterView(withName: Constants.Views.makeCall)
    private let animateCallButton: UIView = {
        let button = UIView()
        return button
    }()
    
    let siteButton = FilterView(withName: Constants.Views.toSite)
    private let animateSiteButton: UIView = {
        let button = UIView()
        return button
    }()
    
    private var favoriteName: String = ""
    private var phone: String = ""
    private var url: String = ""
    private var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0,
                                                                                 longitude: 0.0)
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    func setupFavoriteName(name: String, phone: String, url: String, location: CLLocationCoordinate2D) {
        favoriteName = name
        self.phone = phone
        self.url = url
        print("000 currentLocation:\(currentLocation)")
        currentLocation = location
        print("111 currentLocation:\(currentLocation)")
    }
    
    private func setupUI() {
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
        
        let tapSearch = UITapGestureRecognizer(target: self, action: #selector(handleRouteButton))
        routeButton.addGestureRecognizer(tapSearch)
        
        let tapFavorites = UITapGestureRecognizer(target: self, action: #selector(handleAddToFavouritesButton))
        addToFavouritesButton.addGestureRecognizer(tapFavorites)
        
        let tapSearchSight = UITapGestureRecognizer(target: self, action: #selector(handleCallButton))
        callButton.addGestureRecognizer(tapSearchSight)
        
        let tapMuseum = UITapGestureRecognizer(target: self, action: #selector(handleSiteButton))
        siteButton.addGestureRecognizer(tapMuseum)
        
        
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
        print("currentLocation:\(currentLocation)")
        actionButtonDelegate?.routeButtonTapped(location: currentLocation)
    }
    
    // Избранное
    @objc func handleAddToFavouritesButton() {
        print("favoriteName:\(favoriteName)")
        actionButtonDelegate?.addToFavouritesButtonTapped(name: favoriteName)
    }
    
    // Достопримечательность
    @objc func handleCallButton() {
        print("phone:\(phone)")
        actionButtonDelegate?.callButtonTapped(withNumber: phone)
    }
    
    // Музей
    @objc func handleSiteButton() {
        print("url:\(url)")
        actionButtonDelegate?.siteButtonTapped(urlString: url)
    }
}

