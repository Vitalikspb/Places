////
////  ExibitionsController.swift
////  TabBarTest
////
////  Created by VITALIY SVIRIDOV on 13.11.2021.
////
//
//import UIKit
//
//protocol ExibitionsDisplayLogic: AnyObject {
//    func displayExibitions(viewModel: ExibitionsModels.Exibitions.ViewModel)
//}
//
//class ExibitionsController: UIViewController {
//    
//    // MARK: - UI Properties
//    
//    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
//    // выбранной ячейки для тапа по описанию, для увеличения высоты ячейки
//    private var selectedDescriptionCell: Bool = false
//    private var heightOfSelectedCell: CGFloat = 260
//    private var selectedDescriptionIndex: Int = 0
//    
//    // MARK: - Public Properties
//    
//    var interactor: ExibitionsBussinessLogic?
//    var router: (NSObjectProtocol & ExibitionsRoutingLogic & ExibitionsDataPassing)?
//    
//    // массив всех достопримечательностей
//    var data: ExibitionsModels.Exibitions.ViewModel!
//    
//    // MARK: - Life cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationController?.navigationBar.isHidden = false
//        view.backgroundColor = .white
//        interactor?.showExibitions()
//        setupUI()
//    }
//    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        setupClean()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupClean()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        interactor?.showExibitions()
//    }
//    
//    // MARK: - Helper Functions
//    
//    // Настройка архитектуры Clean Swift
//    private func setupClean() {
//        let viewController = self
//        let interactor = ExibitionsInteractor()
//        let presenter = ExibitionsPresenter()
//        let router = ExibitionsRouter()
//        viewController.interactor = interactor
//        viewController.router = router
//        interactor.presenter = presenter
//        presenter.exibitionsController = viewController
//        router.viewController = viewController
//        router.dataStore = interactor
//    }
//    
//    private func setupUI() {
//        
//        tableView.register(ExibitionsTableViewCell.self,
//                           forCellReuseIdentifier: ExibitionsTableViewCell.identifier)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.showsVerticalScrollIndicator = false
//        tableView.showsHorizontalScrollIndicator = false
//        tableView.backgroundColor = .clear
//        tableView.separatorStyle = .none
//        tableView.allowsSelection = true
//        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
//        
//        view.addSubview(tableView)
//        tableView.anchor(top: view.topAnchor,
//                         left: view.leftAnchor,
//                         bottom: view.bottomAnchor,
//                         right: view.rightAnchor,
//                         paddingTop: 0,
//                         paddingLeft: 0,
//                         paddingBottom: 0,
//                         paddingRight: 0,
//                         width: 0, height: 0)
//    }
//    
//}
//
//// MARK: - CountryDisplayLogic
//
//extension ExibitionsController: ExibitionsDisplayLogic {
//    func displayExibitions(viewModel: ExibitionsModels.Exibitions.ViewModel) {
//        data = viewModel
//        title = "Экскурсии по \(data.country)"
//        tableView.reloadData()
//    }
//}
//
//// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
//
//extension ExibitionsController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data?.events.count ?? 0
//    }
//    
//    // заполнение каждой ячейки
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExibitionsTableViewCell.identifier, for: indexPath) as? ExibitionsTableViewCell else { return UITableViewCell() }
//        
//        cell.configureCell(name: data.events[indexPath.row].name,
//                           image: data.events[indexPath.row].image,
//                           reviewsStar: data.events[indexPath.row].reviewsStar,
//                           reviewsCount: data.events[indexPath.row].reviewsCount,
//                           price: data.events[indexPath.row].price,
//                           duration: data.events[indexPath.row].duration)
//        return cell
//    }
//    
//    // высота каждой ячейки
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return heightOfSelectedCell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("indexPath.row: \(indexPath.row)")
//    }
//}
