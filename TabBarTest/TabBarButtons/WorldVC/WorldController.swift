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
    
    private let searchBar: UISearchBar = UISearchBar()
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
        // поисковая строка
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Поиск города"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        
        // коллекшн вью
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        
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
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        searchBar.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: nil,
                         right: view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0,
                         height: 50)
        
        collectionView.anchor(top: searchBar.bottomAnchor,
                              left: view.leftAnchor,
                              bottom: view.bottomAnchor,
                              right: view.rightAnchor,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0,
                              height: 0)
        
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
            ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as! SectionHeader
        reusableview.frame = CGRect(x: 0 , y: 0, width: self.view.frame.width, height: 80)
        reusableview.countryNameLabel.text = filteredTableData.model[indexPath.section].titlesec.name
        reusableview.subTitleLabel.text = filteredTableData.model[indexPath.section].titlesec.subName
        reusableview.delegate = self
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.87), heightDimension: .fractionalWidth(0.55))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    // Настройка лейаута хедера
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
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
        cell.configureCell(type: filteredTableData.model[indexPath.section].items[indexPath.row].name,
                           name: filteredTableData.model[indexPath.section].items[indexPath.row].subName,
                           image: filteredTableData.model[indexPath.section].items[indexPath.row].imageCity)
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

// MARK: - UISearchBarDelegate

extension WorldController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let countSymbol = searchText.count
        if countSymbol != 0 {
            filteredTableData.model.removeAll()
            
            for (_,val0) in filteredTableData.model.enumerated() {
                let searchSectionTextName = String(val0.titlesec.name.prefix(countSymbol)).capitalized
                if searchSectionTextName == searchText.capitalized {
                    filteredTableData.model.append(val0)
                } else {
                    for (_,val1) in val0.items.enumerated() {
                        let searchItemTextName = String(val1.name.prefix(countSymbol)).capitalized
                        if searchItemTextName == searchText.capitalized {
                            filteredTableData.model.append(val0)
                        }
                    }
                }
            }
        } else {
            filteredTableData = viewModel
        }
        
        if viewModel.model.isEmpty {
            filteredTableData = viewModel
        }
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

// MARK: - SectionHeaderDelegate

extension WorldController: SectionHeaderDelegate {
    // нажимаем на пноку показа страны
    func showCountyToBuy(countryName: String) {
        router?.dataStore?.currentCity = countryName
        router?.routeToCountryVC()
    }
}
