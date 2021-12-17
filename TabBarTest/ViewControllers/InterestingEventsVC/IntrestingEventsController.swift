//
//  FavouritesController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol IntrestingEventsDisplayLogic: AnyObject {
    func displayIntrestingEvents(viewModel: IntrestingEventsModels.IntrestingEvents.ViewModel)
}

class IntrestingEventsController: UIViewController {
    
    // MARK: - UI Properties
    
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    // выбранной ячейки для тапа по описанию, для увеличения высоты ячейки
    
    // MARK: - Public Properties
    
    var interactor: IntrestingEventsBussinessLogic?
    var router: (NSObjectProtocol & IntrestingEventsRoutingLogic & IntrestingEventsDataPassing)?
    
    // массив всех достопримечательностей
    var data: IntrestingEventsModels.IntrestingEvents.ViewModel!
    
    // MARK: - Private Properties
    
    private let userDefault = UserDefaults.standard
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        setupUI()
        interactor?.showIntrestingEvents()
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
        let interactor = IntrestingEventsInteractor()
        let presenter = IntrestingEventsPresenter()
        let router = IntrestingEventsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.intrestingEventsController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        tableView.register(InterestingEventsTableViewCell.self,
                           forCellReuseIdentifier: InterestingEventsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
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
extension IntrestingEventsController: IntrestingEventsDisplayLogic {
    func displayIntrestingEvents(viewModel: IntrestingEventsModels.IntrestingEvents.ViewModel) {
        data = viewModel
        title = "События в \(data.country)"
        tableView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension IntrestingEventsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.events.count ?? 0
    }
    
    // заполнение каждой ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InterestingEventsTableViewCell.identifier, for: indexPath) as? InterestingEventsTableViewCell else { return UITableViewCell() }

        cell.configureCell(title: data.events[indexPath.row].name,
                           description: data.events[indexPath.row].descriptions,
                           date: data.events[indexPath.row].date,
                           image: data.events[indexPath.row].image.first!)
        return cell
    }
    
    // высота каждой ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    // белое заполнение пустой части таблицы
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.dataStore?.name = data.events[indexPath.row].name
        router?.dataStore?.description = data.events[indexPath.row].descriptions
        router?.dataStore?.image = data.events[indexPath.row].image
        router?.routeToSelectedEventVC()
    }
}
