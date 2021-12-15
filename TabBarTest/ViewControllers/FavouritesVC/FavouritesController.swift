//
//  FavouritesController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol FavouritesDisplayLogic: AnyObject {
    func displayFavourites(viewModel: FavouritesViewModel.FavouritesSight.ViewModel)
}

class FavouritesController: UIViewController {
    
    // MARK: - UI Properties
    private let topTableView = FavouritesTopView(frame: CGRect(x: 0,
                                                               y: 0,
                                                               width: UIScreen.main.bounds.width,
                                                               height: 200))
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    // MARK: - TODO
    // создать ячейку для коллекции - верхний список
    // создать ячейку для таблицы - в ней будет коллекия в которой будут ячейки
    
    
    // MARK: - Public Properties
    
    var interactor: FavouritesBussinessLogic?
    var router: (NSObjectProtocol & FavouritesRoutingLogic & FavouritesDataPassing)?
    
    // массив всех достопримечательностей
    var data: FavouritesViewModel.FavouritesSight.ViewModel!
    
    private let userDefault = UserDefaults.standard
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        setupClean()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.showFavourites()
        
        topTableView.dataModel = data.allSight

        
    }
    
    // MARK: - Helper Functions
    
    // Настройка архитектуры Clean Swift
    private func setupClean() {
        let viewController = self
        let interactor = FavouritesInteractor()
        let presenter = FavouritesPresenter()
        let router = FavouritesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.favouritesController = viewController
        router.viewController = viewController
        //        router.dataStore = interactor
    }
    
    private func setupUserDefault() {
        
    }
    
    private func setupUI() {
        title = Constants.Favourites.titleScreen
        // скролл картинок
        
        // таблица
        tableView.register(FavouritesTableViewCell.self,
                           forCellReuseIdentifier: FavouritesTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.tableHeaderView = topTableView
        
        view.addSubview(tableView)
        topTableView.delegate = self
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
    
//    private func
}

// MARK: - CountryDisplayLogic
extension FavouritesController: FavouritesDisplayLogic {
    func displayFavourites(viewModel: FavouritesViewModel.FavouritesSight.ViewModel) {
        data = viewModel
        tableView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension FavouritesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.county[section].city.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data?.county.count ?? 0
    }
    
    // заполнение каждой ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesTableViewCell.identifier, for: indexPath) as? FavouritesTableViewCell else { return UITableViewCell() }
        
        // 5 всех достопримечательностей
        // массив для заполенния достопримечательносей в каждой ячейке
        var allCitiesSight = [FavouritesTableViewCell.CitySight]()
        for (_, valueSight) in data.county[indexPath.section].city[indexPath.row].citySight.enumerated() {
            allCitiesSight.append(FavouritesTableViewCell.CitySight(
                                    sightType: valueSight.sightType,
                                    sightName: valueSight.sightName,
                                    sightImage: valueSight.sightImage,
                                    sightFavouritesFlag: valueSight.sightFavouritesFlag))
        }
        
        
        cell.configCell(data: FavouritesTableViewCell.CellModel(
                            city: data.county[indexPath.section].city[indexPath.row].city,
                            descriptionCity: allCitiesSight))
        cell.delegate = self
        return cell
    }
    
    // высота каждой ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // ячейка с кнопками
        return 220
        
    }
    
    // хедер страна
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data.county[section].county
    }
    
    // белое заполнение пустой части таблицы
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
}

extension FavouritesController: FavouritesTableViewCellDelegate {
    func showSelectedSightOnMap(_ name: String) {
        print("FavouritesTableViewCellDelegate tap on cell sight with name: \(name)")
        userDefault.set(true, forKey: UserDefaults.showSelectedSight)
        userDefault.set(name, forKey: UserDefaults.showSelectedSightName)
        tabBarController?.selectedIndex = 0
    }
}

