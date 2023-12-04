//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol ScrollViewOnMapDelegate: AnyObject {
    func showSearchView()
    func chooseSight()
    func chooseMuseum()
    func chooseCultureObject()
    func chooseGod()
}

// Скролл фильтрации на карте сверху

class ScrollViewOnMap: UIScrollView {
    
    // MARK: - UI properties
    
    // поиск
    private let searchFilter = FilterView(withName: Constants.Views.search, andImage: UIImage(named: "search")!)
    
    // Достопримечательность (замок, заповедник, водопад, пещеры, Смотровая площадка, Транспорт, Парки, скверы, Рынок, еда
    private let sightFilter = FilterView(withName: Constants.Views.sights, andImage: UIImage(named: "museum")!)
    
    // Музей (выставка, зоопарк)
    private let transportFilter = FilterView(withName: Constants.Views.museum, andImage: UIImage(named: "transport")!)
    
    // Культурный объект (Статуя, памятник (дом писателя, мост, оперы, )
    private let leisureFilter = FilterView(withName: Constants.Views.cultureObject, andImage: UIImage(named: "sight")!)
    
    // Богослужение (церкви, храмы, мечети и тд)
    private let worshipFilter = FilterView(withName: Constants.Views.worship, andImage: UIImage(named: "temple")!)
    
    // MARK: - Public properties
    
    weak var onMapdelegate: ScrollViewOnMapDelegate?
    
    // MARK: - Private properties
    
    private var isSelected: Bool = false
    
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
        
        [searchFilter, sightFilter, transportFilter, leisureFilter, worshipFilter].forEach {
            $0.backgroundColor = .setCustomColor(color: .filterViewMainSearch)
        }
        
        let tapSearch = UITapGestureRecognizer(target: self, action: #selector(handleSearchFilter))
        searchFilter.addGestureRecognizer(tapSearch)
        
        let tapSearchSight = UITapGestureRecognizer(target: self, action: #selector(handleSightFilter))
        sightFilter.addGestureRecognizer(tapSearchSight)
        
        let tapMuseum = UITapGestureRecognizer(target: self, action: #selector(handleMuseumFilter))
        transportFilter.addGestureRecognizer(tapMuseum)
        
        let tapCultureObject = UITapGestureRecognizer(target: self, action: #selector(handleCultureObjectFilter))
        leisureFilter.addGestureRecognizer(tapCultureObject)
        
        let tapGod = UITapGestureRecognizer(target: self, action: #selector(handleGodFilter))
        worshipFilter.addGestureRecognizer(tapGod)
        
        addSubview(searchFilter)
        addSubview(sightFilter)
        addSubview(transportFilter)
        addSubview(leisureFilter)
        addSubview(worshipFilter)
        
        updateFullWidth()
    }
    
    func updateFullWidth() {
        let searchWidth = searchFilter.frame.width
        let sightWidth = sightFilter.frame.width
        let transportWidth = transportFilter.frame.width
        let leisureWidth = leisureFilter.frame.width
        let worshipWidth = worshipFilter.frame.width
        
        let frameSearch = CGRect(x: 16,
                                 y: 2,
                                 width: searchWidth,
                                 height: 40)
        searchFilter.frame = frameSearch
        
        let frameSight = CGRect(x: searchWidth + 28,
                                y: 2,
                                width: sightWidth,
                                height: 40)
        sightFilter.frame = frameSight
        
        let frameTransport = CGRect(x: searchWidth + sightWidth + 40,
                                    y: 2,
                                    width: transportWidth,
                                    height: 40)
        transportFilter.frame = frameTransport
        
        let frameLeisure = CGRect(x: searchWidth + sightWidth + transportWidth + 52,
                                  y: 2,
                                  width: leisureWidth,
                                  height: 40)
        leisureFilter.frame = frameLeisure
        
       
       
        
        let frameWorship = CGRect(x: searchWidth + sightWidth + transportWidth + leisureWidth + 64,
                                  y: 2,
                                  width: worshipWidth,
                                  height: 40)
        worshipFilter.frame = frameWorship

        self.contentSize = CGSize(width: searchWidth + sightWidth + transportWidth + leisureWidth + worshipWidth + 76,
                                  height: 40)
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
            let frame = CGRect(x: 24,
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
    
    func setupAnimate(filterView: FilterView) {
        [searchFilter, sightFilter, transportFilter, leisureFilter, worshipFilter].forEach { currentView in
            
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
    
    @objc func handleSightFilter() {
        onMapdelegate?.chooseSight()
        
        setupAnimate(filterView: sightFilter)
    }
    @objc func handleMuseumFilter() {
        onMapdelegate?.chooseMuseum()
        setupAnimate(filterView: transportFilter)
    }
    @objc func handleCultureObjectFilter() {
        setupAnimate(filterView: leisureFilter)
    }
    @objc func handleGodFilter() {
        setupAnimate(filterView: worshipFilter)
    }
    
}

