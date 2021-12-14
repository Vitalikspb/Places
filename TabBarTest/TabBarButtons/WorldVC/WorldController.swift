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
    
    // MARK: - Public Properties
    
    var interactor: WorldBussinessLogic?
    var router: (NSObjectProtocol & WorldRoutingLogic & WorldDataPassing)?
    var currentCity: String = ""
    
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
    
    
    // MARK: - UI Properties
    
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupClean()
        setupUI()
        viewModel =  WorldViewModels.AllCountriesInTheWorld.ViewModel(country: [WorldViewModels.WorldModel(name: "", image: UIImage(named: "hub3")!)])
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Страны"
        viewModel.country.removeAll()
        // в интеракторе создаем большую модель для заполнения всех ячеек таблицы, заголовка, погоды и всей остальой инфорамции
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
        // скролл картинок
        tableView.register(InterestingEventsTableViewCell.self,
                           forCellReuseIdentifier: InterestingEventsTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .white
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

extension WorldController: WorldDisplayLogic {
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели
    func displayAllCities(viewModel: WorldViewModels.AllCountriesInTheWorld.ViewModel) {
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
        return viewModel.country.count
    }
    
    // MARK: - заполнение каждой ячейки
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InterestingEventsTableViewCell.identifier, for: indexPath) as? InterestingEventsTableViewCell else { return UITableViewCell() }
        cell.configureCell(title: viewModel.country[indexPath.row].name,
                           description: "Descriptions",
                           date: "00-00-0000",
                           image: [viewModel.country[indexPath.row].image,viewModel.country[indexPath.row].image,], indexPathRow: indexPath.row)
        return cell
    }
    
    // MARK: - высота каждой ячейки
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    // MARK: - белое заполнение пустой части таблицы
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
}



