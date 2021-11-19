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
    // выбранной ячейки для тапа по описанию и погоде, для увеличения высоты ячейки
    private var selectedDescriptionCell: Bool = false
    private var selectedWeatherCell: Bool = false
    
    // MARK: - UI Properties
    
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupClean()
        setupUI()
        viewModel =  [CountryViewModel.CityModel(name: "",
                                                 image: UIImage(named: "hub3")!)]
        tabBarController?.tabBar.items?[1].title = "Текущее"
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = userDefault.string(forKey: UserDefaults.currentCity)
        viewModel.removeAll()
        //        interactor?.showCity()
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
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        view.addSubview(tableView)
        
        tableView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0, height: 0)
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
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryPhotosTableViewCell.identifier, for: indexPath) as? CountryPhotosTableViewCell else { return UITableViewCell() }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryDescriptionTableViewCell.identifier, for: indexPath) as? CountryDescriptionTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            selectedDescriptionCell ?
                cell.moreButtons.setTitle("Скрыть", for: .normal) :
                cell.moreButtons.setTitle("Читать далее", for: .normal)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCitiesTableViewCell.identifier, for: indexPath) as? CountryCitiesTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            
            return cell
        default: return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        // ячейка с картинками текущего города
        case 0: return UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3) + 32
        // ячейка с описанием города
        case 1: return selectedDescriptionCell ? 380 : 200
        // ячейка с другими городами текущей страны где есть метки
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

extension CountryController: CountryDescriptionTableViewCellDelegate {
    func showMoreText() {
        selectedDescriptionCell = !selectedDescriptionCell
        
        tableView.reloadData()
    }
    
    
}

extension CountryController: CountryCitiesTableViewCellDelegate {
    func showSelectedCityOnMap(_ lat: Double, _ lon: Double) {
            self.userDefault.set(true, forKey: UserDefaults.showSelectedCity)
            self.userDefault.set(lat, forKey: UserDefaults.showSelectedCityWithLatitude)
            self.userDefault.set(lon, forKey: UserDefaults.showSelectedCityWithLongitude)
            self.tabBarController?.selectedIndex = 0
    }
}





