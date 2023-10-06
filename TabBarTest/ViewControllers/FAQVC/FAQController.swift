//
//  FAQController.swift
//  TabBarTest
//
//  Created by ViceCode on 17.12.2021.
//


import UIKit

protocol FAQDisplayLogic: AnyObject {
    func displayFAQ(viewModel: FAQModels.RentAuto.ViewModel)
}

// MARK: - экран помощи

class FAQController: UIViewController {
    
    // MARK: - Public Properties

    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    // MARK: - Public Properties
    
    var interactor: FAQBussinessLogic?
    var router: (NSObjectProtocol & FAQRoutingLogic & FAQDataPassing)?
    var viewModel: FAQModels.RentAuto.ViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        interactor?.showFAQ()
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: - Helper Functions
    
    // Настройка архитектуры Clean Swift
    private func setupClean() {
        let viewController = self
        let interactor = FAQInteractor()
        let presenter = FAQPresenter()
        let router = FAQRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.faqController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
      
    private func setupUI() {
        tableView.register(FAQTableViewCell.self,
                           forCellReuseIdentifier: FAQTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        view.addSubviews(tableView)
        tableView.addConstraintsToFillView(view: view)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension FAQController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.FAQModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FAQTableViewCell.identifier, for: indexPath) as? FAQTableViewCell else { return UITableViewCell() }
        let currentModel = viewModel.FAQModel[indexPath.row]
        cell.configureCell(question: currentModel.question,
                           answer: currentModel.answer)
        return cell
    }
}

// MARK: - CountryDisplayLogic

extension FAQController: FAQDisplayLogic {
    // показ информации о текущем городе
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели
    func displayFAQ(viewModel: FAQModels.RentAuto.ViewModel) {
        self.viewModel = viewModel
        title = self.viewModel.currentCity
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}
