//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol ScrollViewOnMapDelegate: AnyObject {
    func showSearchView()
    func chooseSightSelected(selected: Bool, request: TypeSight)
}

// Скролл фильтрации на карте сверху

class ScrollViewOnMap: UIScrollView {
    
    // MARK: - UI properties
    
    // поиск
    private let searchFilter = FilterView(withName: Constants.Views.search, 
                                          andImage: UIImage(named: "search")!)
    // избранное
    private let favoriteFilter = FilterView(withName: Constants.Views.features,
                                             andImage: UIImage(systemName: "heart.fill")!)
    // Достопримечательность
    private let sightFilter = FilterView(withName: Constants.Views.sights, 
                                         andImage: UIImage(named: "museum")!)
    // Музей
    private let transportFilter = FilterView(withName: Constants.Views.museum, 
                                             andImage: UIImage(named: "museumSearch")!)
    // Культурный объект
    private let leisureFilter = FilterView(withName: Constants.Views.cultureObject, 
                                           andImage: UIImage(named: "sight")!)
    // Богослужение
    private let worshipFilter = FilterView(withName: Constants.Views.worship, 
                                           andImage: UIImage(named: "temple")!)
    
    // MARK: - Public properties
    
    weak var onMapdelegate: ScrollViewOnMapDelegate?
    
    // MARK: - Private properties
    
    private var isSelected: Bool = false
    private var currentFilter: FilterView?
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.isScrollEnabled = true
        self.isDirectionalLockEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        [searchFilter, favoriteFilter, sightFilter, transportFilter, leisureFilter, worshipFilter].forEach {
            $0.backgroundColor = .setCustomColor(color: .filterViewMainSearch)
        }
        
        let tapSearch = UITapGestureRecognizer(target: self, action: #selector(handleSearchFilter))
        searchFilter.addGestureRecognizer(tapSearch)
        
        let tapFavorites = UITapGestureRecognizer(target: self, action: #selector(handleFavoritesFilter))
        favoriteFilter.addGestureRecognizer(tapFavorites)
        
        let tapSearchSight = UITapGestureRecognizer(target: self, action: #selector(handleSightFilter))
        sightFilter.addGestureRecognizer(tapSearchSight)
        
        let tapMuseum = UITapGestureRecognizer(target: self, action: #selector(handleMuseumFilter))
        transportFilter.addGestureRecognizer(tapMuseum)
        
        let tapCultureObject = UITapGestureRecognizer(target: self, action: #selector(handleCultureObjectFilter))
        leisureFilter.addGestureRecognizer(tapCultureObject)
        
        let tapGod = UITapGestureRecognizer(target: self, action: #selector(handleGodFilter))
        worshipFilter.addGestureRecognizer(tapGod)
        
        addSubview(searchFilter)
        addSubview(favoriteFilter)
        addSubview(sightFilter)
        addSubview(transportFilter)
        addSubview(leisureFilter)
        addSubview(worshipFilter)
        
        updateFullWidth()
    }
    
    func updateFullWidth() {
        let searchWidth = searchFilter.frame.width
        let favoritesWidth = favoriteFilter.frame.width
        let sightWidth = sightFilter.frame.width
        let transportWidth = transportFilter.frame.width
        let leisureWidth = leisureFilter.frame.width
        let worshipWidth = worshipFilter.frame.width
        
        let frameSearch = CGRect(x: 16,
                                 y: 2,
                                 width: searchWidth,
                                 height: 40)
        searchFilter.frame = frameSearch
        
        let frameFavorites = CGRect(x: searchWidth + 28,
                                 y: 2,
                                 width: favoritesWidth,
                                 height: 40)
        favoriteFilter.frame = frameFavorites
        
        let frameSight = CGRect(x: favoritesWidth + searchWidth + 40,
                                y: 2,
                                width: sightWidth,
                                height: 40)
        sightFilter.frame = frameSight
        
        let frameTransport = CGRect(x: favoritesWidth + searchWidth + sightWidth + 52,
                                    y: 2,
                                    width: transportWidth,
                                    height: 40)
        transportFilter.frame = frameTransport
        
        let frameLeisure = CGRect(x: favoritesWidth + searchWidth + sightWidth + transportWidth + 64,
                                  y: 2,
                                  width: leisureWidth,
                                  height: 40)
        leisureFilter.frame = frameLeisure
        
        let frameWorship = CGRect(x: favoritesWidth + searchWidth + sightWidth + transportWidth + leisureWidth + 76,
                                  y: 2,
                                  width: worshipWidth,
                                  height: 40)
        worshipFilter.frame = frameWorship

        self.contentSize = CGSize(width: favoritesWidth + searchWidth + sightWidth + transportWidth + leisureWidth + worshipWidth + 88,
                                  height: 40)
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
            [self.searchFilter, self.favoriteFilter, self.sightFilter, self.transportFilter,
             self.leisureFilter, self.worshipFilter].forEach {
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
            let frame = CGRect(x: 16,
                               y: 2,
                               width: filterView.frame.width,
                               height: 40)
            filterView.frame = frame
            self.contentSize = CGSize(width: filterView.frame.width + 200,
                                      height: self.frame.height)
            
        } completion: { success in
            if success {
                self.isSelected = true
            }
        }
    }
    
    func updateFilterView() {
        isSelected = true
        guard let currentFilter = currentFilter else { return }
        setupAnimate(filterView: currentFilter)
    }
    
    private func setupAnimate(filterView: FilterView) {
        [searchFilter, favoriteFilter, sightFilter, transportFilter,
         leisureFilter, worshipFilter].forEach { currentView in
            
            if currentView === filterView {
                filterView.backgroundColor = .setCustomColor(color: .filterViewMainSearch)
                filterView.label.textColor = .setCustomColor(color: .titleText)
                filterView.myImage.tintColor = .setCustomColor(color: .titleText)
                
                isSelected
                // показать все фильтры
                ? showAllFilters()
                // уменьшить ширину скролл и пересичитать констейны для поиска и выбранного фильтра
                : hideAllFilters(withCurrent: filterView)
                self.updateConstraints()
            } else {
                UIView.animate(withDuration: 0.55) { [weak self] in
                    guard let self = self else { return }
                    currentView.alpha = !self.isSelected ? 0 : 1
                }
            }
        }
    }
    
    // Поиск
    @objc func handleSearchFilter() {
        onMapdelegate?.showSearchView()
    }
    
    // Избранное
    @objc func handleFavoritesFilter() {
        onMapdelegate?.chooseSightSelected(selected: isSelected, request: .favorite)
        currentFilter = favoriteFilter
        setupAnimate(filterView: favoriteFilter)
    }
    
    // Достопримечательность
    @objc func handleSightFilter() {
        onMapdelegate?.chooseSightSelected(selected: isSelected, request: .sightSeen)
        currentFilter = sightFilter
        setupAnimate(filterView: sightFilter)
    }
    
    // Музей
    @objc func handleMuseumFilter() {
        onMapdelegate?.chooseSightSelected(selected: isSelected, request: .museum)
        currentFilter = transportFilter
        setupAnimate(filterView: transportFilter)
    }
    
    // Культурный объект
    @objc func handleCultureObjectFilter() {
        onMapdelegate?.chooseSightSelected(selected: isSelected, request: .cultureObject)
        currentFilter = leisureFilter
        setupAnimate(filterView: leisureFilter)
    }
    
    // Богослужение
    @objc func handleGodFilter() {
        onMapdelegate?.chooseSightSelected(selected: isSelected, request: .god)
        currentFilter = worshipFilter
        setupAnimate(filterView: worshipFilter)
    }
    
}

