//
//  SelectedInterestingEventController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol SelectedInterestingEventDisplayLogic: AnyObject {
    func displayAllCities(viewModel: SelectedInterestingEventViewModel.EventModels.ViewModel)
}

// MARK: - Экран конкретное выбранное место

class SelectedInterestingEventController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: SelectedInterestingEventBussinessLogic?
    var router: (NSObjectProtocol & SelectedInterestingEventRoutingLogic & SelectedInterestingEventDataPassing)?
    var currentCity: String = ""
    
    // MARK: - Private Properties
    
    private var titleName: String = ""
    var viewModel: SelectedInterestingEventViewModel.EventModels.ViewModel!
    
    // MARK: - UI Properties
    
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.textColor = .setCustomColor(color: .titleText)
        label.textAlignment = .left
        label.font = .setCustomFont(name: .semibold, andSize: 16)
        label.text = "00-00-0000"
        return label
    }()
    private let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.allowsSelection = false
        table.isUserInteractionEnabled = true
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        return table
    }()
    private let mainTextView: UITextView = {
       let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isUserInteractionEnabled = false
        textView.font = .setCustomFont(name: .regular, andSize: 16)
        return textView
    }()

    // MARK: - Private properties
    
    private let layout = UICollectionViewFlowLayout()
    private lazy var modelImage = [UIImage]()
    private var descriptionEvent: String = ""
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .setCustomColor(color: .mainView)
        setupUI()
        interactor?.showEvent()
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
        let interactor = SelectedInterestingEventInteractor()
        let presenter = SelectedInterestingEventPresenter()
        let router = SelectedInterestingEventRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.selectedInterestingEventController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = true
        
        layout.scrollDirection = .horizontal
        collectionView.register(InterestingEventsCollectionViewCell.self,
                                forCellWithReuseIdentifier: InterestingEventsCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        layout.itemSize = CGSize(width: 220, height: 170)
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        view.addSubviews(dateLabel, collectionView, tableView)
        
        dateLabel.anchor(top: view.layoutMarginsGuide.topAnchor,
                          left: view.leftAnchor,
                          bottom: nil,
                          right: view.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 0, height: 25)
        
        collectionView.anchor(top: dateLabel.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: nil,
                         right: view.rightAnchor,
                         paddingTop: 16,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0, height: 190)
        
        tableView.anchor(top: collectionView.bottomAnchor,
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

extension SelectedInterestingEventController: SelectedInterestingEventDisplayLogic {
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели
    func displayAllCities(viewModel: SelectedInterestingEventViewModel.EventModels.ViewModel) {
        self.viewModel = viewModel
        title = viewModel.event.nameEvent
        modelImage = [UIImage()]//viewModel.event.image
        descriptionEvent = viewModel.event.mainText
        dateLabel.text = "Дата проведения \(viewModel.event.date)"
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension SelectedInterestingEventController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestingEventsCollectionViewCell.identifier, for: indexPath) as? InterestingEventsCollectionViewCell else { return UICollectionViewCell() }
        cell.conigureCell(image: modelImage[indexPath.row])
        return cell
    }
    
    // Отступы от краев экрана на крайних ячейках
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    // Расстояние между ячейками - белый отступ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SelectedInterestingEventController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = descriptionEvent
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
}






