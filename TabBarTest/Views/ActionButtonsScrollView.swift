//
//  ActionButtonsScrollView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.10.2021.
//

import UIKit

protocol ActionButtonsScrollViewDelegate {
    func showSearchView()
    func chooseSightFilter(completion: @escaping() -> (Bool))
    func chooseParkFilter()
    func choosePoiFilter()
    func chooseBeachFilter()
}

class ActionButtonsScrollView: UIScrollView {
    
    var onMapdelegate: ScrollViewOnMapDelegate?
    private var isSelected: Bool = false
    
    private let searchFilter = FilterView(withName: "Маршрут")
    private let sightFilter = FilterView(withName: "В избранное")
    private let transportFilter = FilterView(withName: "Позвонить")
    private let leisureFilter = FilterView(withName: "Поделиться")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        self.backgroundColor = .white
        self.isScrollEnabled = true
        self.isDirectionalLockEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        [searchFilter, sightFilter, transportFilter,
         leisureFilter].forEach {
            $0.layer.cornerRadius = 18
            $0.backgroundColor = UIColor.white
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.systemBlue.cgColor
//            $0.standartShadow(view: $0)
        }
        
        let tapSearch = UITapGestureRecognizer(target: self, action: #selector(handleSearchFilter))
        searchFilter.addGestureRecognizer(tapSearch)
        let tapSearchSight = UITapGestureRecognizer(target: self, action: #selector(handleSightFilter))
        sightFilter.addGestureRecognizer(tapSearchSight)
        let tapSearchTransport = UITapGestureRecognizer(target: self, action: #selector(handleTransportFilter))
        transportFilter.addGestureRecognizer(tapSearchTransport)
        let tapSearchLeisure = UITapGestureRecognizer(target: self, action: #selector(handleLeisureFilter))
        leisureFilter.addGestureRecognizer(tapSearchLeisure)
        
        addSubview(searchFilter)
        addSubview(sightFilter)
        addSubview(transportFilter)
        addSubview(leisureFilter)

        updateFullWidth()
    }
    
    func updateFullWidth() {
        let searchWidth = searchFilter.frame.width
        let sightWidth = sightFilter.frame.width
        let transportWidth = transportFilter.frame.width
        let leisureWidth = leisureFilter.frame.width
        
        let frameSearch = CGRect(x: 12,
                                 y: 6,
                                 width: searchWidth,
                                 height: 36)
        searchFilter.frame = frameSearch
        
        let frameSight = CGRect(x: searchWidth + 24,
                                y: 6,
                                width: sightWidth,
                                height: 36)
        sightFilter.frame = frameSight
        
        let frameTransport = CGRect(x: searchWidth + sightWidth + 36,
                                    y: 6,
                                    width: transportWidth,
                                    height: 36)
        transportFilter.frame = frameTransport
        
        let frameLeisure = CGRect(x: searchWidth + sightWidth + transportWidth + 48,
                                  y: 6,
                                  width: leisureWidth,
                                  height: 36)
        leisureFilter.frame = frameLeisure
    
        self.contentSize = CGSize(width: searchWidth + sightWidth + transportWidth + leisureWidth + 60,
                                  height: self.frame.height)
    }
    
    @objc func handleSearchFilter() {
        onMapdelegate?.showSearchView()
    }
    
    // показать все фильтры
    private func showAllFilters() {
        UIView.animate(withDuration: 0.35) { [weak self] in
            guard let self = self else { return }
            self.updateFullWidth()
        }
        // анимация появления
        UIView.animate(withDuration: 0.55) { [weak self] in
            guard let self = self else { return }
            
            [self.searchFilter, self.sightFilter, self.transportFilter,
             self.leisureFilter].forEach {
                $0.alpha = 1
            }
            
        } completion: { success in
            if success {
                self.isSelected = false
            }
        }
    }
    
    // уменьшить ширину скролл и пересичитать констейны для поиска и выбранного фильтра
    private func hideAllFilters(withCurrent filterView: FilterView) {
        UIView.animate(withDuration: 0.55) { [weak self] in
            guard let self = self else { return }
            let frame = CGRect(x: 24,
                               y: 2,
                               width: filterView.frame.width,
                               height: 36)
            filterView.frame = frame
            self.contentSize = CGSize(width: filterView.frame.width + 200,
                                      height: self.frame.height)
            
        } completion: { success in
            if success {
                self.isSelected = true
            }
        }
    }
    
    func setupAnimate(filterView: FilterView) {
        [self.searchFilter, sightFilter, transportFilter,
         leisureFilter].forEach { currentView in
            
            if currentView === filterView {
                filterView.backgroundColor = filterView.backgroundColor == .white ? .systemBlue : .white
                filterView.label.textColor = filterView.label.textColor == .systemBlue ? .white : .systemBlue
                filterView.myImage.tintColor = filterView.myImage.tintColor == .systemBlue ? .white : .systemBlue
                
                if isSelected {
                    // показать все фильтры
                    showAllFilters()
                } else {
                    // уменьшить ширину скролл и пересичитать констейны для поиска и выбранного фильтра
                    hideAllFilters(withCurrent: filterView)
                }
                self.updateConstraints()
            } else {
                UIView.animate(withDuration: 0.55) {
                    currentView.alpha = !self.isSelected ? 0 : 1
                }
                currentView.backgroundColor = .white
                currentView.label.textColor = .systemBlue
                currentView.myImage.tintColor = .systemBlue
            }
        }
    }
    
    @objc func handleSightFilter() {
        onMapdelegate?.chooseSightFilter(completion: {
            return self.isSelected ? false : true
        })
        setupAnimate(filterView: sightFilter)
    }
    @objc func handleTransportFilter() {
        setupAnimate(filterView: transportFilter)
    }
    @objc func handleLeisureFilter() {
        setupAnimate(filterView: leisureFilter)
    }
    
    
}


