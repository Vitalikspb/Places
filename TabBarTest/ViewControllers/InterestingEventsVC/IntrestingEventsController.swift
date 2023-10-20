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

// MARK: - Экран Интересные места

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
        view.backgroundColor = .setCustomColor(color: .mainView)
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
        title = "Интересные события"
        tableView.register(InterestingEventsTableViewCell.self,
                           forCellReuseIdentifier: InterestingEventsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 16, right: 0)
        tableView.allowsSelection = false
        
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
    
}

// MARK: - CountryDisplayLogic
extension IntrestingEventsController: IntrestingEventsDisplayLogic {
    
    func displayIntrestingEvents(viewModel: IntrestingEventsModels.IntrestingEvents.ViewModel) {
        data = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }   
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
        
        let mdl = data.events[indexPath.row]
        let model = InterestingEventsTableViewCell.InterestingEventsModel(name: mdl.name,
                                                                          date: mdl.date,
                                                                          description: mdl.description,
                                                                          image: mdl.images[0],
                                                                          id: indexPath.row)
        cell.configureCell(model: model)
        cell.delegate = self
        return cell
    }
    
    // высота каждой ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }

}

// MARK: - InterestingEventsTableViewCellDelegate

extension IntrestingEventsController: InterestingEventsTableViewCellDelegate {
    
    func selectEvents(id: Int) {
        let data = data.events[id]
        router?.dataStore?.city = data.name
        router?.dataStore?.description = data.description
        router?.dataStore?.images = data.images
        router?.dataStore?.date = data.date
        router?.routeToSelectedEventVC()
    }
    
    
}
