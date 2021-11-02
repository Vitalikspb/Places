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
    
    // MARK: - Helper Functions
    
    private func setupUI() {
        
        self.backgroundColor = .white
        self.isScrollEnabled = true
        self.isDirectionalLockEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        [routeButton, addToFavouritesButton, callButton,
         shareButton].forEach {
            $0.layer.cornerRadius = 18
            $0.backgroundColor = UIColor.white
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.systemBlue.cgColor
        }
        
        let tapSearch = UITapGestureRecognizer(target: self, action: #selector(handleRouteButton))
        routeButton.addGestureRecognizer(tapSearch)
        let tapSearchSight = UITapGestureRecognizer(target: self, action: #selector(handleAddToFavouritesButton))
        addToFavouritesButton.addGestureRecognizer(tapSearchSight)
        let tapSearchTransport = UITapGestureRecognizer(target: self, action: #selector(handleCallButton))
        callButton.addGestureRecognizer(tapSearchTransport)
        let tapSearchLeisure = UITapGestureRecognizer(target: self, action: #selector(handleShareButton))
        shareButton.addGestureRecognizer(tapSearchLeisure)
        
        addSubview(routeButton)
        addSubview(addToFavouritesButton)
        addSubview(callButton)
        addSubview(shareButton)

        updateFullWidth()
    }
    
    func updateFullWidth() {
        let searchWidth = routeButton.frame.width
        let sightWidth = addToFavouritesButton.frame.width
        let transportWidth = callButton.frame.width
        let leisureWidth = shareButton.frame.width
        
        let frameSearch = CGRect(x: 12,
                                 y: 6,
                                 width: searchWidth,
                                 height: 36)
        routeButton.frame = frameSearch
        
        let frameSight = CGRect(x: searchWidth + 24,
                                y: 6,
                                width: sightWidth,
                                height: 36)
        addToFavouritesButton.frame = frameSight
        
        let frameTransport = CGRect(x: searchWidth + sightWidth + 36,
                                    y: 6,
                                    width: transportWidth,
                                    height: 36)
        callButton.frame = frameTransport
        
        let frameLeisure = CGRect(x: searchWidth + sightWidth + transportWidth + 48,
                                  y: 6,
                                  width: leisureWidth,
                                  height: 36)
        shareButton.frame = frameLeisure
    
        self.contentSize = CGSize(width: searchWidth + sightWidth + transportWidth + leisureWidth + 60,
                                  height: self.frame.height)
    }
    
    
    
    
}


