//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol CountryDisplayLogic: AnyObject {
    func displayAllCities(viewModel: CountryViewModel.AllCitiesInCurrentCountry.ViewModel)
}

class CountryController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: CountryBussinessLogic?
    var router: (NSObjectProtocol & CountryRoutingLogic)?
    
    // MARK: - Private Properties
    
    private let sizeOfHeightCell: CGFloat = 235
    private var titleName: String = ""
    var viewModel: [CountryViewModel.CityModel]!
    private let userDefault = UserDefaults.standard
    // MARK: - UI Properties
    
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupClean()
        setupUI()
        viewModel =  [CountryViewModel.CityModel(name: "",
                                                 image: UIImage(named: "new-york")!)]
        tabBarController?.tabBar.items?[1].title = "Текущее"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUserDefault()
        viewModel.removeAll()
        interactor?.showCity()
    }
    
    
    // MARK: - Helper Functions
    
    // Настройка архитектуры Clean Swift
    private func setupClean() {
        let viewController = self
        let interactor = CountryInteractor()
        let presenter = CountryPresenter()
        let router = CountryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.CountryController = viewController
        router.viewController = viewController
    }
    
    func setupUserDefault() {
        guard let userDefault = UserDefaults.standard.string(forKey: UserDefaults.currentLocation) else { return }
        titleName = userDefault
        title = titleName
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.register(CountryCollectionViewCell.self,
                                forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.setCollectionViewLayout(layout, animated: true)
        view.addSubview(collectionView)
        collectionView.addConstraintsToFillView(view: view)
    }
    
}

// MARK: - CountryDisplayLogic
extension CountryController: CountryDisplayLogic {
    func displayAllCities(viewModel: CountryViewModel.AllCitiesInCurrentCountry.ViewModel) {
        self.viewModel = viewModel.cities
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CountryController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectionViewCell.identifier, for: indexPath) as? CountryCollectionViewCell else { return UICollectionViewCell() }
        cell.conigureCell(title: viewModel[indexPath.row].name,
                          image: viewModel[indexPath.row].image)
        cell.presentMap = { (lat, lon) in
            self.userDefault.set(true, forKey: UserDefaults.showSelectedCity)
            self.userDefault.set(lat, forKey: UserDefaults.showSelectedCityWithLatitude)
            self.userDefault.set(lon, forKey: UserDefaults.showSelectedCityWithLongitude)
            self.tabBarController?.selectedIndex = 0
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.showCurrentCity(viewModel[indexPath.row].name)
        router?.routeToCityVC()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CountryController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 45) / 2, height: sizeOfHeightCell)
    }
}




