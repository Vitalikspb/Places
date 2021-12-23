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
    
    // MARK: - TODO удалить
    struct ServiceAuto: Hashable {
        var titlesec: titleSection
        var items: [ItemData]
    }
    struct ItemData: Hashable {
        let name: String
        let subName: String
    }
    struct titleSection: Hashable {
        let name: String
        let subName: String
    }
    var dataSource: UICollectionViewDiffableDataSource<titleSection, ItemData>?
    var rentsService = [
        ServiceAuto(titlesec: titleSection(name: "Section1", subName: "subTitle1"),
                                   items: [ItemData(name: "name1", subName: "sub name1"),
                                           ItemData(name: "name2", subName: "sub name2"),
                                           ItemData(name: "name3", subName: "sub name3"),
                                           ItemData(name: "name4", subName: "sub name4"),
                                           ItemData(name: "name5", subName: "sub name5"),
                                           ItemData(name: "name6", subName: "sub name6"),
                                           ItemData(name: "name7", subName: "sub name7"),
                                           ItemData(name: "name8", subName: "sub name8"),
                                           ItemData(name: "name9", subName: "sub name9")]),
        ServiceAuto(titlesec: titleSection(name: "Section2", subName: "subTitle2"),
                                   items: [ItemData(name: "name1-2", subName: "sub name1-2"),
                                           ItemData(name: "name2-2", subName: "sub name2-2"),
                                           ItemData(name: "name3-2", subName: "sub name3-2"),
                                           ItemData(name: "name4-2", subName: "sub name4-2"),
                                           ItemData(name: "name5-2", subName: "sub name5-2"),
                                           ItemData(name: "name6-2", subName: "sub name6-2"),
                                           ItemData(name: "name7-2", subName: "sub name7-2"),
                                           ItemData(name: "name8-2", subName: "sub name8-2"),
                                           ItemData(name: "name9-2", subName: "sub name9-2")]),
        ServiceAuto(titlesec: titleSection(name: "Section3", subName: "subTitle3"),
                                   items: [ItemData(name: "name1-3", subName: "sub name1-3"),
                                           ItemData(name: "name2-3", subName: "sub name2-3"),
                                           ItemData(name: "name3-3", subName: "sub name3-3"),
                                           ItemData(name: "name4-3", subName: "sub name4-3"),
                                           ItemData(name: "name5-3", subName: "sub name5-3"),
                                           ItemData(name: "name6-3", subName: "sub name6-3"),
                                           ItemData(name: "name7-3", subName: "sub name7-3"),
                                           ItemData(name: "name8-3", subName: "sub name8-3"),
                                           ItemData(name: "name9-3", subName: "sub name9-3")]),
    ]
    // MARK: - TODO удалить
    
    
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
    private var filteredTableData = WorldViewModels.AllCountriesInTheWorld.ViewModel(
        country: [WorldViewModels.WorldModel(name: "", image: UIImage(named: "hub3")!)])
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupClean()
        setupUI()
        viewModel =  WorldViewModels.AllCountriesInTheWorld.ViewModel(
            country: [WorldViewModels.WorldModel(name: "", image: UIImage(named: "hub3")!)])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        title = "Страны"
        viewModel.country.removeAll()
        filteredTableData.country.removeAll()
        // в интеракторе создаем большую модель для заполнения всех ячеек таблицы,
        // заголовка, погоды и всей остальой инфорамции
        interactor?.showCity()
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
//        searchBar.searchBarStyle = UISearchBar.Style.default
//        searchBar.placeholder = "Поиск страны"
//        searchBar.sizeToFit()
//        searchBar.isTranslucent = false
//        searchBar.backgroundImage = UIImage()
//        searchBar.delegate = self
 
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
        
//        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        collectionView.addConstraintsToFillView(view: view)
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
                return nil
            }

            guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return nil }
            if section.name.isEmpty { return nil }

            sectionHeader.title.text = section.name
            sectionHeader.subtitle.text = section.subName
            return sectionHeader
        }
    }
    
}

extension WorldController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as! SectionHeader
            reusableview.frame = CGRect(x: 0 , y: 0, width: self.view.frame.width, height: 80)

        reusableview.title.text = rentsService[indexPath.section].titlesec.name
        reusableview.subtitle.text = rentsService[indexPath.section].titlesec.subName
                return reusableview
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            self.createMediumTableSection()
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
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
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
}

extension WorldController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return rentsService.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rentsService[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorldCollectionViewCell.identifier, for: indexPath) as? WorldCollectionViewCell else { return UICollectionViewCell() }

        cell.configureCell(title: rentsService[indexPath.section].items[indexPath.row].name,
                           subtitle: rentsService[indexPath.section].items[indexPath.row].subName)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("выбран: \(rentsService[indexPath.section].items[indexPath.row].name)")
    }
}

// MARK: - CountryDisplayLogic

extension WorldController: WorldDisplayLogic {
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели
    func displayAllCities(viewModel: WorldViewModels.AllCountriesInTheWorld.ViewModel) {
        self.viewModel = viewModel
        filteredTableData = viewModel
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
            filteredTableData.country.removeAll()
            viewModel.country.forEach {
                let searchTextName = String($0.name.prefix(countSymbol)).capitalized
                if searchTextName == searchText.capitalized {
                    filteredTableData.country.append($0)
                }
            }
        } else {
            filteredTableData = viewModel
        }
        
        if filteredTableData.country.isEmpty {
            filteredTableData = viewModel
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
    
}



