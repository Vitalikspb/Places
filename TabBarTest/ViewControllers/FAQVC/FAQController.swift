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
    
    struct HeightOfCells {
        var bigCell: CGFloat
        var smallCell: CGFloat
    }
    
    // MARK: - Public Properties
    private let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    // MARK: - Public Properties
    
    var interactor: FAQBussinessLogic?
    var router: (NSObjectProtocol & FAQRoutingLogic & FAQDataPassing)?
    var viewModel: FAQModels.RentAuto.ViewModel!
    
    // MARK: - Private properties
    
    private var selectedIndex: Int = -1
    private var lastIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    private var heightOfCells: [HeightOfCells] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        interactor?.showFAQ()
        heightOfCells.removeAll()
        setupUI()
        setupHeightOfCells()
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
    
    private func setupHeightOfCells() {
        viewModel.FAQModel.forEach {
            let standartSmallHeightCell: CGFloat = 43
            let standartBigHeightCell: CGFloat = standartSmallHeightCell + 35
            let standartInsetScreen: CGFloat = 60
            let bigCellHeight = $0.answer.height(
                widthScreen: UIScreen.main.bounds.width - standartInsetScreen,
                font: .setCustomFont(name: .bold, andSize: 16))
            let smallCellHeight = $0.question.height(
                widthScreen: UIScreen.main.bounds.width - standartInsetScreen,
                font: .setCustomFont(name: .bold, andSize: 16))
            heightOfCells.append(
                HeightOfCells(bigCell: bigCellHeight + standartBigHeightCell,
                              smallCell: smallCellHeight + standartSmallHeightCell)
            )
        }
    }
    
    private func setupUI() {
        tableView.register(FAQTableViewCell.self,
                           forCellReuseIdentifier: FAQTableViewCell.identifier)
        
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
        return indexPath.row == selectedIndex
            ? heightOfCells[indexPath.row].bigCell
            : heightOfCells[indexPath.row].smallCell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    // Белое заполнение пустой части таблицы
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row == selectedIndex ? -1 : indexPath.row
        
        let updateIndexPath = [IndexPath(row: indexPath.row, section: 0), IndexPath(row: lastIndexPath.row, section: 0)]
        tableView.reloadRows(at: updateIndexPath, with: .automatic)
        
        if updateIndexPath.first != updateIndexPath.last {
        guard let cell = tableView.cellForRow(at: updateIndexPath.first!) as? FAQTableViewCell else { return }
        cell.arrowImage = indexPath.row == selectedIndex ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill"
        
        guard let cell = tableView.cellForRow(at: updateIndexPath.last!) as? FAQTableViewCell else { return }
            cell.arrowImage = indexPath.row == lastIndexPath.row ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill"
        } else {
            guard let cell = tableView.cellForRow(at: updateIndexPath.first!) as? FAQTableViewCell else { return }
            cell.arrowImage = indexPath.row == selectedIndex ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill"
        }
        lastIndexPath = indexPath
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
