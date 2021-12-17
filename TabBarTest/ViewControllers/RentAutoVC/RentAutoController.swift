//
//  RentAutoController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol RentAutoDisplayLogic: AnyObject {
    func displayRentAuto(viewModel: RentAutoModels.RentAuto.ViewModel)
}

class RentAutoController: UIViewController {

    
    // MARK: - UI Properties
    
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    
    // MARK: - Public Properties
    
    var interactor: RentAutoBussinessLogic?
    var router: (NSObjectProtocol & RentAutoRoutingLogic & RentAutoDataPassing)?
    var viewModel: RentAutoModels.RentAuto.ViewModel!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        setupUI()
        interactor?.showRentAuto()
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
        let interactor = RentAutoInteractor()
        let presenter = RentAutoPresenter()
        let router = RentAutoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.rentAutoController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUserDefault() {
        
    }
    
    private func setupUI() {
        title = "Аренда автомобилей"
        tableView.register(RentAutoTableViewCell.self,
                           forCellReuseIdentifier: RentAutoTableViewCell.identifier)

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

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension RentAutoController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewModel.rentsService[section].rents.count : viewModel.rentsService[section].taxi.count
    }
    // MARK: - заполнение каждой ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RentAutoTableViewCell.identifier, for: indexPath) as? RentAutoTableViewCell else { return UITableViewCell() }
        
        let modelRent = viewModel.rentsService[indexPath.section].rents[indexPath.row]
        let modelTaxi = viewModel.rentsService[indexPath.section].taxi[indexPath.row]
        
        switch indexPath.section {
        case 0: cell.configureCell(name: modelRent.name, image: modelRent.image)
        case 1: cell.configureCell(name: modelTaxi.name, image: modelTaxi.image)
        default: break
        }
        
        return cell
    }
    
    // Высота каждой ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Аренда автомобиля" : "Такси"
    }
    
    // Белое заполнение пустой части таблицы
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPath.section == 0
        ?
        print("выбран: \(viewModel.rentsService[indexPath.section].rents[indexPath.row].name)")
        :
        print("выбран: \(viewModel.rentsService[indexPath.section].taxi[indexPath.row].name)")
    }
}

// MARK: - CountryDisplayLogic
extension RentAutoController: RentAutoDisplayLogic {
    // показ информации о текущем городе
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели
    func displayRentAuto(viewModel: RentAutoModels.RentAuto.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

