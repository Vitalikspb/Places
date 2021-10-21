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
    
    
    // поиск
    private let searchFilter = FilterView(withName: "Поиск", andImage: UIImage(systemName: "sunrise")!)
    
    // Достопримечательность -
    // Замки, Музеи, Памятики,
    private let sightFilter = FilterView(withName: "Достопримечательность", andImage: UIImage(systemName: "mail")!)
    
    // Транспорт -
    // ЖДВокзал, АвтоВокзал, Аэропорт
    private let transportFilter = FilterView(withName: "Транспорт", andImage: UIImage(systemName: "sunrise")!)
    
    // Досуг -
    // Смотровая прощадка, Аквапарки, Выставки, Пещеры, Зоопарки, Заповедники, Водопады
    private let leisureFilter = FilterView(withName: "Досуг", andImage: UIImage(systemName: "sunrise")!)
    
    // Рынок
    private let marketFilter = FilterView(withName: "Рынок", andImage: UIImage(systemName: "sunrise")!)
    
    // Пляж
    private let beachFilter = FilterView(withName: "Пляж", andImage: UIImage(systemName: "sunrise")!)
    
    // Богослужение -
    // Храм, Мечеть, Церковь, Синагога, Собор
    private let worshipFilter = FilterView(withName: "Богослужение", andImage: UIImage(systemName: "sunrise")!)
    
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
            $0.layer.cornerRadius = 18
            $0.backgroundColor = UIColor.white
            $0.standartShadow(view: $0)
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
        
        
        let searchWidth = searchFilter.frame.width
        let sightWidth = sightFilter.frame.width
        let transportWidth = transportFilter.frame.width
        let leisureWidth = leisureFilter.frame.width
        let marketWidth = marketFilter.frame.width
        let beachWidth = beachFilter.frame.width
        let worshipWidth = worshipFilter.frame.width
        
        let frameSearch = CGRect(x: 12,
                                 y: 2,
                                 width: searchWidth,
                                 height: 36)
        searchFilter.frame = frameSearch
        
        let frameSight = CGRect(x: searchWidth + 24,
                                y: 2,
                                width: sightWidth,
                                height: 36)
        sightFilter.frame = frameSight
        
        let frameTransport = CGRect(x: searchWidth + sightWidth + 36,
                                    y: 2,
                                    width: transportWidth,
                                    height: 36)
        transportFilter.frame = frameTransport
        
        let frameLeisure = CGRect(x: searchWidth + sightWidth + transportWidth + 48,
                                  y: 2,
                                  width: leisureWidth,
                                  height: 36)
        leisureFilter.frame = frameLeisure
        
        let frameMarket = CGRect(x: searchWidth + sightWidth + transportWidth + leisureWidth + 60,
                                 y: 2,
                                 width: marketWidth,
                                 height: 36)
    
        marketFilter.frame = frameMarket
        let frameBeach = CGRect(x: searchWidth + sightWidth + transportWidth + leisureWidth + marketWidth + 72,
                                y: 2,
                                width: beachWidth,
                                height: 36)
        
        beachFilter.frame = frameBeach
        let frameWorship = CGRect(x: searchWidth + sightWidth + transportWidth + leisureWidth + marketWidth + beachWidth + 84,
                                  y: 2,
                                  width: worshipWidth,
                                  height: 36)
        worshipFilter.frame = frameWorship
        
        
        
        
        self.contentSize = CGSize(width: searchWidth + sightWidth + transportWidth + leisureWidth + marketWidth + beachWidth + worshipWidth + 96,
                                  height: self.frame.height)
    }
    
    @objc func handleSearchFilter() {
        onMapdelegate?.showSearchView()
        
        [sightFilter, transportFilter,
         leisureFilter, marketFilter, beachFilter, worshipFilter].forEach {
            $0.backgroundColor = .white
        }
    }

    @objc func handleSightFilter() {
        onMapdelegate?.chooseSightFilter(completion: {
            return self.sightFilter.backgroundColor == .white ? true : false
        })
        sightFilter.backgroundColor = sightFilter.backgroundColor == .white ? .systemBlue : .white
    }
    @objc func handleTransportFilter() {
        transportFilter.backgroundColor = transportFilter.backgroundColor == .white ? .systemBlue : .white
    }
    @objc func handleLeisureFilter() {
        leisureFilter.backgroundColor = leisureFilter.backgroundColor == .white ? .systemBlue : .white
    }
    @objc func handleMarketFilter() {

        marketFilter.backgroundColor = marketFilter.backgroundColor == .white ? .systemBlue : .white
    }
    @objc func handleBeachFilter() {

        beachFilter.backgroundColor = beachFilter.backgroundColor == .white ? .systemBlue : .white
    }
    @objc func handleWorshipFilter() {
        worshipFilter.backgroundColor = worshipFilter.backgroundColor == .white ? .systemBlue : .white
    }

}

