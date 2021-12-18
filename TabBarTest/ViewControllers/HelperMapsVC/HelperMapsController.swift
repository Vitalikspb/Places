//
//  HelperMapsController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.12.2021.
//

import UIKit

protocol HelperMapsDisplayLogic: AnyObject {
    func displayHelperMaps(viewModel: RentAutoModels.RentAuto.ViewModel)
}

class HelperMapsController: UIViewController {

    
    // MARK: - UI Properties
    private let topSeparator: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    
    // MARK: - Public Properties
    
    var interactor: HelperMapsBussinessLogic?
    var router: (NSObjectProtocol & HelperMapsRoutingLogic & HelperMapsDataPassing)?
    var viewModel: RentAutoModels.RentAuto.ViewModel!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        
        interactor?.showHelperMaps()
        setupUI()
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
        let interactor = HelperMapsInteractor()
        let presenter = HelperMapsPresenter()
        let router = HelperMapsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.helperMapsController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUserDefault() {
        
    }
    
    private func setupUI() {
        tableView.register(RentAutoTableViewCell.self,
                           forCellReuseIdentifier: RentAutoTableViewCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.allowsSelection = true
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        view.addSubview(topSeparator)
        view.addSubview(tableView)
        topSeparator.centerX(inView: view)
        topSeparator.anchor(top: view.topAnchor,
                            left: nil,
                            bottom: nil,
                            right: nil,
                            paddingTop: 10,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 100, height: 4)
        tableView.anchor(top: topSeparator.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 10,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0, height: 0)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HelperMapsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewModel.rentsService.rents.count : viewModel.rentsService.taxi.count
    }
    // MARK: - заполнение каждой ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RentAutoTableViewCell.identifier, for: indexPath) as? RentAutoTableViewCell else { return UITableViewCell() }
        
        let modelRent = viewModel.rentsService.rents[indexPath.row]
        let modelTaxi = viewModel.rentsService.taxi[indexPath.row]
        
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
        print("выбран: \(viewModel.rentsService.rents[indexPath.row].name)")
        :
        print("выбран: \(viewModel.rentsService.taxi[indexPath.row].name)")
    }
}

// MARK: - CountryDisplayLogic
extension HelperMapsController: HelperMapsDisplayLogic {
    // показ информации о текущем городе
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели
    func displayHelperMaps(viewModel: RentAutoModels.RentAuto.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}
