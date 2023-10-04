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
    private let countryLabel: UILabel = {
       let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .center
        label.font = .setCustomFont(name: .semibold, andSize: 20)
        label.text = "Россия"
        label.backgroundColor = .clear
        return label
    }()
    
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
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
        setupClean()
        setupUI()
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
        presenter.favouritesController = viewController
        router.viewController = viewController
    }
    
    private func setupUserDefault() {
        
    }
    
    private func setupUI() {
        title = Constants.Favourites.titleScreen
        self.view.backgroundColor = .setCustomColor(color: .mainView)
        
        tableView.register(FavouritesTableViewCell.self,
                           forCellReuseIdentifier: FavouritesTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        view.addSubviews(countryLabel, tableView)
        countryLabel.anchor(top: view.layoutMarginsGuide.topAnchor,
                            left: view.leftAnchor,
                            bottom: nil,
                            right: view.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0, height: 50)
        tableView.anchor(top: countryLabel.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 8,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0, height: 0)
    }
    
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
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesTableViewCell.identifier, for: indexPath) as? FavouritesTableViewCell else { return UITableViewCell() }

        cell.configCell(city: data.model[indexPath.section].titlesec.city,
                        data: data.model[indexPath.section].items)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

// MARK: - FavouritesTableViewCellDelegate

extension FavouritesController: FavouritesTableViewCellDelegate {
    
    func tapFavouriteButton() {
        print("Добавить или удалить выбранный гоорд")
    }
    
    func showCity(name: String) {
        print("открыть выбранный город из избранного")
    }

}

