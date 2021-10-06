//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol ScrollViewOnMapDelegate {
    func showSearchView()
    func chooseMuseumFilter(completion: @escaping() -> (Bool))
    func chooseParkFilter()
    func choosePoiFilter()
    func chooseBeachFilter()
}

class ScrollViewOnMap: UIScrollView {
    
    var onMapdelegate: ScrollViewOnMapDelegate?
    
    private let filter = FilterView(withName: "Поиск", andImage: UIImage(systemName: "sunrise")!)
    private let filter1 = FilterView(withName: "Музеи", andImage: UIImage(systemName: "terminal")!)
    private let filter2 = FilterView(withName: "Парки", andImage: UIImage(systemName: "mail")!)
    private let filter3 = FilterView(withName: "Смотровые площадки", andImage: UIImage(systemName: "sunrise")!)
    private let filter4 = FilterView(withName: "Пляжи", andImage: UIImage(systemName: "sunrise")!)
    
    private let shadowFilterView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.60
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 2
        return view
    }()
    private let shadowFilterView1: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.60
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 2
        return view
    }()
    private let shadowFilterView2: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.60
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 2
        return view
    }()
    private let shadowFilterView3: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.60
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 2
        return view
    }()
    private let shadowFilterView4: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.60
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 2
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.isScrollEnabled = true
        self.isDirectionalLockEnabled = true
        self.showsHorizontalScrollIndicator = false

        let tapSearch = UITapGestureRecognizer(target: self, action: #selector(handleSearchFilter))
        filter.addGestureRecognizer(tapSearch)
        let tapSearchMuseum = UITapGestureRecognizer(target: self, action: #selector(handleMuseumFilter))
        filter1.addGestureRecognizer(tapSearchMuseum)
        let tapSearchPark = UITapGestureRecognizer(target: self, action: #selector(handleParkFilter))
        filter2.addGestureRecognizer(tapSearchPark)
        let tapSearchPoi = UITapGestureRecognizer(target: self, action: #selector(handlePoiFilter))
        filter3.addGestureRecognizer(tapSearchPoi)
        let tapSearchBeach = UITapGestureRecognizer(target: self, action: #selector(handleBeachFilter))
        filter4.addGestureRecognizer(tapSearchBeach)
        
        addSubview(shadowFilterView)
        addSubview(shadowFilterView1)
        addSubview(shadowFilterView2)
        addSubview(shadowFilterView3)
        addSubview(shadowFilterView4)
        addSubview(filter)
        addSubview(filter1)
        addSubview(filter2)
        addSubview(filter3)
        addSubview(filter4)


        
        let frameOne = CGRect(x: 12, y: 2,
                               width: filter.frame.width, height: 36)
        filter.frame = frameOne
        shadowFilterView.frame = frameOne
        
        let frameTwo = CGRect(x: filter.frame.width+24, y: 2,
                               width: filter1.frame.width, height: 36)
        filter1.frame = frameTwo
        shadowFilterView1.frame = frameTwo
        
        let frameThree = CGRect(x: filter.frame.width+filter1.frame.width+36, y: 2,
                                width: filter2.frame.width, height: 36)
        filter2.frame = frameThree
        shadowFilterView2.frame = frameThree
        
        let frameFour = CGRect(x: filter.frame.width+filter1.frame.width+filter2.frame.width+48, y: 2,
                               width: filter3.frame.width, height: 36)
        filter3.frame = frameFour
        shadowFilterView3.frame = frameFour
        
        let frameFive = CGRect(x: filter.frame.width+filter1.frame.width+filter2.frame.width+filter3.frame.width+60, y: 2,
                               width: filter4.frame.width, height: 36)
        filter4.frame = frameFive
        shadowFilterView4.frame = frameFive
        
        self.contentSize = CGSize(width: filter.frame.width + filter1.frame.width +
                                    filter2.frame.width + filter3.frame.width + filter4.frame.width + 72,
                                  height: self.frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleSearchFilter() {
        onMapdelegate?.showSearchView()
        filter1.backgroundColor = .white
        filter2.backgroundColor = .white
        filter3.backgroundColor = .white
        filter4.backgroundColor = .white
    }
    @objc func handleMuseumFilter() {
        onMapdelegate?.chooseMuseumFilter(completion: {
            return self.filter1.backgroundColor == .white ? true : false
        })
        filter1.backgroundColor = filter1.backgroundColor == .white ? .systemBlue : .white
    }
    @objc func handleParkFilter() {
        onMapdelegate?.chooseParkFilter()
        filter2.backgroundColor = filter2.backgroundColor == .white ? .systemBlue : .white
    }
    @objc func handlePoiFilter() {
        onMapdelegate?.choosePoiFilter()
        filter3.backgroundColor = filter3.backgroundColor == .white ? .systemBlue : .white
    }
    @objc func handleBeachFilter() {
        onMapdelegate?.chooseBeachFilter()
        filter4.backgroundColor = filter4.backgroundColor == .white ? .systemBlue : .white
    }

}

