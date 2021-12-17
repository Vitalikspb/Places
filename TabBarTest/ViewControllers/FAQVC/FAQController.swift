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

class FAQController: UIViewController {

    // MARK: - Public Properties
    
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    // MARK: - Public Properties
    
    var interactor: FAQBussinessLogic?
    var router: (NSObjectProtocol & FAQRoutingLogic & FAQDataPassing)?
    var viewModel: FAQModels.RentAuto.ViewModel!
    
    // MARK: - Private properties
    
    private var selectedIndex: Int = -1

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        setupUI()
        interactor?.showFAQ()
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
    
    private func setupUserDefault() {
        
    }
    
    private func setupUI() {
        title = "Вопросы и ответы"
        tableView.register(FAQTableViewCell.self,
                           forCellReuseIdentifier: FAQTableViewCell.identifier)

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

extension FAQController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.FAQModel.count
    }
    // MARK: - заполнение каждой ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FAQTableViewCell.identifier, for: indexPath) as? FAQTableViewCell else { return UITableViewCell() }
        let currentModel = viewModel.FAQModel[indexPath.row]
        cell.configureCell(question: currentModel.question,
                           answer: currentModel.answer)

        return cell
    }
    
    // Высота каждой ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == selectedIndex ? 130 : 70
    }
    
    
    // Белое заполнение пустой части таблицы
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row == selectedIndex ? -1 : indexPath.row
        let indexPath = [IndexPath(row: indexPath.row, section: 0)]
        tableView.reloadRows(at: indexPath, with: .automatic)
        guard let cell = tableView.cellForRow(at: indexPath.first!) as? FAQTableViewCell else { return }
        cell.arrowImage = selectedIndex == -1 ? "map" : "star"
    }
}

// MARK: - CountryDisplayLogic
extension FAQController: FAQDisplayLogic {
    // показ информации о текущем городе
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели
    func displayFAQ(viewModel: FAQModels.RentAuto.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}
