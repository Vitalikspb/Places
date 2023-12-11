//
//  WorldController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol WorldDisplayLogic: AnyObject {
    func displayAllCities(viewModel: [WorldViewModels.AllCountriesInTheWorld.ViewModel])
}

class WorldController: UIViewController {
    
    // MARK: - UI Properties
    
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    // MARK: - Public Properties
    
    var interactor: WorldBussinessLogic?
    var router: (NSObjectProtocol & WorldRoutingLogic & WorldDataPassing)?
    var viewModel: [WorldViewModels.AllCountriesInTheWorld.ViewModel]!
    
    // MARK: - Private Properties
    
    private let userDefault = UserDefaults.standard
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .setCustomColor(color: .mainView)
        setupClean()
        setupUI()
        title = "Страны"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        interactor?.showCity()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupClean()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupClean()
    }
    
    // MARK: - Helper Functions
    
    // Настройка архитектуры Clean Swift
    private func setupClean() {
        let viewController = self
        let interactor = WorldInteractor()
        let presenter = WorldPresenter()
        let router = WorldRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.WorldController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        // другие города
        tableView.register(WorldCollectionViewCell.self,
                           forCellReuseIdentifier: WorldCollectionViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 16, right: 0)
        
        view.addSubviews(tableView)
        
        tableView.anchor(top: view.layoutMarginsGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.layoutMarginsGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0, height: 0)
    }
    
    // Переход на карту
    
    func showSelectedItemOnMap(city: Bool, latitude lat: Double, longitude lon: Double) {
        userDefault.set(lat, forKey: UserDefaults.showSelectedCityWithLatitude)
        userDefault.set(lon, forKey: UserDefaults.showSelectedCityWithLongitude)
        userDefault.set(true, forKey: city == true
                        ? UserDefaults.showSelectedCity
                        : UserDefaults.showSelectedCountry)
        tabBarController?.selectedIndex = 0
    }
}

// MARK: - CountryDisplayLogic

extension WorldController: WorldDisplayLogic {
    
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели
    func displayAllCities(viewModel: [WorldViewModels.AllCountriesInTheWorld.ViewModel]) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension WorldController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorldCollectionViewCell.identifier,
                                                       for: indexPath) as? WorldCollectionViewCell,
              let modelCities = viewModel[indexPath.row].model else { return UITableViewCell() }
        
        let item = viewModel[indexPath.row]
        cell.configureHeaderCell(header: item.titlesec,
                                 cities: modelCities,
                                 alpha: item.titlesec.available ? 1 : 0.65,
                                 available: item.titlesec.available)
        cell.delegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 366
    }
}

// MARK: - WorldCollectionViewCellDelegate

extension WorldController: WorldCollectionViewCellDelegate {

    // Переход на карту с выбранным городом или страной
    func showOnMap(name: String) {
        print("Переход на карту с выбранной страной:\(name)")
        // открываем выбранный город на карте
        let selectedCity = UserDefaults.standard.getSightDescription().first(where: { $0.name == name })
        let latitude = selectedCity?.latitude ?? 0.0
        let longitude = selectedCity?.longitude ?? 0.0
        showSelectedItemOnMap(city: name == "Россия" ? false : true,
                              latitude: name == "Россия" ? 61.237414 : latitude,
                              longitude: name == "Россия" ? 93.177739 : longitude)
    }
    
    // Переход на выбранный город подробней
    func showSelectedCityDescription(name: String) {
        print("Переход на выбранный город подробней:\(name)")
        router?.dataStore?.currentCountry = name
        router?.routeToCityVC()
    }
    
}
