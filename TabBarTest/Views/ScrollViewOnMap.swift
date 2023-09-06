//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol ScrollViewOnMapDelegate {
    func showSearchView()
    func chooseSightFilter(completion: @escaping() -> (Bool))
    func chooseParkFilter()
    func choosePoiFilter()
    func chooseBeachFilter()
}

class ScrollViewOnMap: UIScrollView {
    
    var onMapdelegate: ScrollViewOnMapDelegate?
    private var isSelected: Bool = false
    
    // поиск
    private let searchFilter = FilterView(withName: Constants.Views.search, andImage: UIImage(named: "search")!)
    
    // Достопримечательность -
    // Замки, Музеи, Памятики,
    private let sightFilter = FilterView(withName: Constants.Views.sights, andImage: UIImage(named: "museum")!)
    
    // Транспорт -
    // ЖДВокзал, АвтоВокзал, Аэропорт
    private let transportFilter = FilterView(withName: Constants.Views.transport, andImage: UIImage(named: "transport")!)
    
    // Досуг -
    // Смотровая прощадка, Аквапарки, Выставки, Пещеры, Зоопарки, Заповедники, Водопады
    private let leisureFilter = FilterView(withName: Constants.Views.relax, andImage: UIImage(named: "sight")!)
    
    // Рынок
    private let marketFilter = FilterView(withName: Constants.Views.market, andImage: UIImage(named: "market")!)
    
    // Пляж
    private let beachFilter = FilterView(withName: Constants.Views.beach, andImage: UIImage(named: "beach")!)
    
    // Богослужение -
    // Храм, Мечеть, Церковь, Синагога, Собор
    private let worshipFilter = FilterView(withName: Constants.Views.worship, andImage: UIImage(named: "temple")!)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.isScrollEnabled = true
        self.isDirectionalLockEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        [searchFilter, sightFilter, transportFilter,
         leisureFilter, marketFilter, beachFilter, worshipFilter].forEach {
            $0.backgroundColor = .setCustomColor(color: .filterViewMainSearch)
        }
        
        
        let tapSearch = UITapGestureRecognizer(target: self, action: #selector(handleSearchFilter))
        searchFilter.addGestureRecognizer(tapSearch)
        let tapSearchSight = UITapGestureRecognizer(target: self, action: #selector(handleSightFilter))
        sightFilter.addGestureRecognizer(tapSearchSight)
        let tapSearchTransport = UITapGestureRecognizer(target: self, action: #selector(handleTransportFilter))
        transportFilter.addGestureRecognizer(tapSearchTransport)
        let tapSearchLeisure = UITapGestureRecognizer(target: self, action: #selector(handleLeisureFilter))
        leisureFilter.addGestureRecognizer(tapSearchLeisure)
        let tapSearchMarket = UITapGestureRecognizer(target: self, action: #selector(handleMarketFilter))
        marketFilter.addGestureRecognizer(tapSearchMarket)
        let tapSearchBeach = UITapGestureRecognizer(target: self, action: #selector(handleBeachFilter))
        beachFilter.addGestureRecognizer(tapSearchBeach)
        let tapSearchWorship = UITapGestureRecognizer(target: self, action: #selector(handleWorshipFilter))
        worshipFilter.addGestureRecognizer(tapSearchWorship)
        
        addSubview(searchFilter)
        addSubview(sightFilter)
        addSubview(transportFilter)
        addSubview(leisureFilter)
        addSubview(marketFilter)
        addSubview(beachFilter)
        addSubview(worshipFilter)
        
        
        updateFullWidth()
    }
    
    func updateFullWidth() {
        let searchWidth = searchFilter.frame.width
        let sightWidth = sightFilter.frame.width
        let transportWidth = transportFilter.frame.width
        let leisureWidth = leisureFilter.frame.width
        let marketWidth = marketFilter.frame.width
        let beachWidth = beachFilter.frame.width
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
        
        let frameMarket = CGRect(x: searchWidth + sightWidth + transportWidth + leisureWidth + 64,
                                 y: 2,
                                 width: marketWidth,
                                 height: 40)
        
        marketFilter.frame = frameMarket
        let frameBeach = CGRect(x: searchWidth + sightWidth + transportWidth + leisureWidth + marketWidth + 76,
                                y: 2,
                                width: beachWidth,
                                height: 40)
        
        beachFilter.frame = frameBeach
        let frameWorship = CGRect(x: searchWidth + sightWidth + transportWidth + leisureWidth + marketWidth + beachWidth + 88,
                                  y: 2,
                                  width: worshipWidth,
                                  height: 40)
        worshipFilter.frame = frameWorship

        self.contentSize = CGSize(width: searchWidth + sightWidth + transportWidth + leisureWidth + marketWidth + beachWidth + worshipWidth + 100,
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
             self.leisureFilter, self.marketFilter,
             self.beachFilter, self.worshipFilter].forEach {
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
        [searchFilter, sightFilter, transportFilter,
         leisureFilter, marketFilter, beachFilter, worshipFilter].forEach { currentView in
            
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
    @objc func handleMarketFilter() {
        setupAnimate(filterView: marketFilter)
    }
    @objc func handleBeachFilter() {
        setupAnimate(filterView: beachFilter)
    }
    @objc func handleWorshipFilter() {
        setupAnimate(filterView: worshipFilter)
    }
    
}

