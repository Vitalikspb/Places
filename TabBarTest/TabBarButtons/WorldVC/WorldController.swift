//
//  WorldController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol WorldDisplayLogic: AnyObject {
    func displayAllCities(viewModel: WorldViewModels.AllCountriesInTheWorld.ViewModel)
}

class WorldController: UIViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<WorldViewModels.TitleSection, WorldViewModels.ItemData>?

    // MARK: - UI Properties
    
    private lazy var collectionView: UICollectionView! = nil
    
    // MARK: - Public Properties
    
    var interactor: WorldBussinessLogic?
    var router: (NSObjectProtocol & WorldRoutingLogic & WorldDataPassing)?
    
    // MARK: - Private Properties
    
    private var titleName: String = ""
    var viewModel: WorldViewModels.AllCountriesInTheWorld.ViewModel!
    // выбранной ячейки для тапа по описанию, для увеличения высоты ячейки
    
    private var isSearch : Bool = false
    private var filteredTableData: WorldViewModels.AllCountriesInTheWorld.ViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupClean()
        setupUI()
        title = "Страны"
        // в интеракторе создаем большую модель для заполнения всех ячеек таблицы,
        // заголовка, погоды и всей остальой инфорамции
        interactor?.showCity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    
    // MARK: - Helper Functions
    
    // Настройка архитектуры Clean Swift
    private func setupClean() {
        let viewController = self
        let interactor = WorldInteractor()
        let presenter = WorldPresenter()
        let router = WorldRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.WorldController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        
        // коллекшн вью
        self.view.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
            
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.register(WorldCollectionViewCell.self,
                                forCellWithReuseIdentifier: WorldCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = false
        
        view.addSubviews(collectionView)
        
        collectionView.addConstraintsToFillView(view: view)
        
        // Настраиваем дата сорс и хедер для коллекшн вью
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
                return nil
            }
            
            guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return nil }
            if section.name.isEmpty { return nil }
            
            sectionHeader.countryNameLabel.text = section.name
            sectionHeader.subTitleLabel.text = section.subName
            return sectionHeader
        }
    }
}

// MARK: - UICollectionViewDiffableDataSource

extension WorldController {
    
    // Настройка хедера в секции
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableview = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeader.reuseIdentifier,
            for: indexPath) as! SectionHeader
        reusableview.frame = CGRect(x: 0 , y: 0, width: self.view.frame.width, height: 80)
        reusableview.countryNameLabel.text = filteredTableData.model[indexPath.section].titlesec.name
        reusableview.subTitleLabel.text = filteredTableData.model[indexPath.section].titlesec.subName
        return reusableview
    }
    
    // Настройка секции
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            self.createMediumTableSection()
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    // Настройка лейаута секции
    func createMediumTableSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.33))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90),
                                                     heightDimension: .fractionalWidth(0.61))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    // Настройка лейаута хедера
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                             heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        return layoutSectionHeader
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension WorldController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return filteredTableData.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredTableData.model[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorldCollectionViewCell.identifier, for: indexPath) as? WorldCollectionViewCell else { return UICollectionViewCell() }
        let model = filteredTableData.model[indexPath.section].items[indexPath.row]
        cell.configureCell(type: model.name,
                           name: model.subName,
                           image: model.imageCity)
        cell.delegate = self
        return cell
    }

}

// MARK: - CountryDisplayLogic

extension WorldController: WorldDisplayLogic {
    
    // Отображение обновленной таблицы после заполнения в интеракторе данными модели
    // Пока что не работает т.к нету модели
    func displayAllCities(viewModel: WorldViewModels.AllCountriesInTheWorld.ViewModel) {
        self.viewModel = viewModel
        self.filteredTableData = viewModel
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}

// MARK: - WorldCollectionViewCellDelegate

extension WorldController: WorldCollectionViewCellDelegate {
    
    // нажимаем на пноку показа города
    func showSelected(show: String) {
        router?.dataStore?.currentCity = show
        router?.routeToCityVC()
    }
}
