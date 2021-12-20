//
//  WorldController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol WorldDisplayLogic: AnyObject {
    func displayAllCities(viewModel: WorldViewModels.AllCountriesInTheWorld.ViewModel)
}

class WorldController: UIViewController {
    
    // MARK: - UI Properties
    
    private lazy var searchBar: UISearchBar = UISearchBar()
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    // MARK: - Public Properties
    
    var interactor: WorldBussinessLogic?
    var router: (NSObjectProtocol & WorldRoutingLogic & WorldDataPassing)?
    
    // MARK: - Private Properties
    
    private var titleName: String = ""
    var viewModel: WorldViewModels.AllCountriesInTheWorld.ViewModel!
    private let userDefault = UserDefaults.standard
    // выбранной ячейки для тапа по описанию, для увеличения высоты ячейки
    private var selectedDescriptionCell: Bool = false
    private struct DescriptionWeather {
        var temp: String
        var feelsLike: String
        var image: UIImage
        var description: String
        var sunrise: String
        var sunset: String
    }
    private var currentWeather: DescriptionWeather!
    private var descriptionHeightCell: CGFloat = 0
    private var isSearch : Bool = false
    private var filteredTableData = WorldViewModels.AllCountriesInTheWorld.ViewModel(
        country: [WorldViewModels.WorldModel(name: "", image: UIImage(named: "hub3")!)])
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupClean()
        setupUI()
        viewModel =  WorldViewModels.AllCountriesInTheWorld.ViewModel(
            country: [WorldViewModels.WorldModel(name: "", image: UIImage(named: "hub3")!)])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        title = "Страны"
        viewModel.country.removeAll()
        filteredTableData.country.removeAll()
        // в интеракторе создаем большую модель для заполнения всех ячеек таблицы,
        // заголовка, погоды и всей остальой инфорамции
        interactor?.showCity()
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
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Поиск страны"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
        tableView.register(CountryToSelectTableViewCell.self,
                           forCellReuseIdentifier: CountryToSelectTableViewCell.identifier)
        tableView.keyboardDismissMode = .onDrag
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
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

extension WorldController: WorldDisplayLogic {
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели
    func displayAllCities(viewModel: WorldViewModels.AllCountriesInTheWorld.ViewModel) {
        self.viewModel = viewModel
        filteredTableData = viewModel
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension WorldController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTableData.country.count
    }
    
    // Заполнение каждой ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryToSelectTableViewCell.identifier, for: indexPath) as? CountryToSelectTableViewCell else { return UITableViewCell() }
        cell.configureCell(title: filteredTableData.country[indexPath.row].name,
                           image: filteredTableData.country[indexPath.row].image)
        return cell
    }
    
    // Высота каждой ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryName = filteredTableData.country[indexPath.row].name
        router?.dataStore?.currentCity = countryName
        router?.routeToCountryVC()
    }
}

// MARK: - UISearchBarDelegate

extension WorldController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let countSymbol = searchText.count
        if countSymbol != 0 {
            filteredTableData.country.removeAll()
            viewModel.country.forEach {
                let searchTextName = String($0.name.prefix(countSymbol)).capitalized
                if searchTextName == searchText.capitalized {
                    filteredTableData.country.append($0)
                }
            }
        } else {
            filteredTableData = viewModel
        }
        
        if filteredTableData.country.isEmpty {
            filteredTableData = viewModel
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
}



