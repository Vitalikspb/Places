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
    
    private var titleName: String = ""
    var viewModel: [CountryViewModel.CityModel]!
    private let userDefault = UserDefaults.standard
    // MARK: - UI Properties
    
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
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
        guard let userDefault = UserDefaults.standard.string(forKey: UserDefaults.currentCity) else { return }
        titleName = userDefault
        title = titleName
    }
    
    private func setupUI() {
        // скролл картинок
        tableView.register(CountryPhotosTableViewCell.self,
                           forCellReuseIdentifier: CountryPhotosTableViewCell.identifier)
        // описание с кнопкой
        tableView.register(CountryDescriptionTableViewCell.self,
                           forCellReuseIdentifier: CountryDescriptionTableViewCell.identifier)
        // другие города
        tableView.register(CountryCitiesTableViewCell.self,
                           forCellReuseIdentifier: CountryCitiesTableViewCell.identifier)
//        // кнопки
//        tableView.register(CountryCollectionViewCell.self,
//                                forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
//        // другие города
//        tableView.register(CountryCollectionViewCell.self,
//                                forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
//        // обязательно к просмотру
//        tableView.register(CountryCollectionViewCell.self,
//                                forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
//        // билеты и экскурсии
//        tableView.register(CountryCollectionViewCell.self,
//                                forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
//        // погода в текущем городе
//        tableView.register(CountryCollectionViewCell.self,
//                                forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
//        // ПЕРЕИСПОЛЬЗУЕМАЯ выбор редакции - лучшие места текущего города
//        tableView.register(CountryCollectionViewCell.self,
//                                forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
//        // ПЕРЕИСПОЛЬЗУЕМАЯ выбор редакции - лучшие места текущего города
//        tableView.register(CountryCollectionViewCell.self,
//                                forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
//        // ПЕРЕИСПОЛЬЗУЕМАЯ выбор редакции - лучшие места текущего города
//        tableView.register(CountryCollectionViewCell.self,
//                                forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
//        // ПЕРЕИСПОЛЬЗУЕМАЯ выбор редакции - лучшие места текущего города
//        tableView.register(CountryCollectionViewCell.self,
//                                forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.addConstraintsToFillView(view: view)
    }
    
}

// MARK: - CountryDisplayLogic
extension CountryController: CountryDisplayLogic {
    func displayAllCities(viewModel: CountryViewModel.AllCitiesInCurrentCountry.ViewModel) {
        self.viewModel = viewModel.cities
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CountryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCitiesTableViewCell.identifier, for: indexPath) as? CountryCitiesTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 100
        case 1: return 300
        case 2: return 220
        default: return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToCityVC()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
}




