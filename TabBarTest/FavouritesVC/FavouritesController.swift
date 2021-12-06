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

    // MARK: - Public Properties
//    let collectionView: UICollectionView = {
//       let collectionView = UICollectionView()
//        return collectionView
//    }()
//    
//    let tableView: UITableView = {
//       let tableView = UITableView()
//        return tableView
//    }()
    
    // MARK: - TODO
    // создать ячейку для коллекции - верхний список
    // создать ячейку для таблицы - в ней будет коллекия в которой будут ячейки
    
    
    // MARK: - Public Properties
    
    var interactor: FavouritesBussinessLogic?
    var router: (NSObjectProtocol & FavouritesRoutingLogic & FavouritesDataPassing)?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        setupClean()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupClean()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.showFavourites()
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
        presenter.FavouritesController = viewController
        router.viewController = viewController
//        router.dataStore = interactor
    }
    
    private func setupUserDefault() {
        
    }
    
    private func setupUI() {
        title = "Избранное"
    }
}

// MARK: - CountryDisplayLogic
extension FavouritesController: FavouritesDisplayLogic {
    func displayFavourites(viewModel: FavouritesViewModel.FavouritesSight.ViewModel) {
        print("Обновили/загрузули информацию на экран по избранным")
    }
}
