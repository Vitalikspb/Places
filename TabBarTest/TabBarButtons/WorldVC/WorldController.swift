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
        let imageCity: UIImage
    }
    struct titleSection: Hashable {
        let name: String
        let subName: String
    }
    var dataSource: UICollectionViewDiffableDataSource<titleSection, ItemData>?
    var rentsService = [
        ServiceAuto(titlesec: titleSection(name: "Россия", subName: "Все города"),
                    items: [ItemData(name: "Санкт-Петерубрг", subName: "Более 454 мест", imageCity: UIImage(named: "hub3")!),
                            ItemData(name: "Москва", subName: "Более 234 мест", imageCity: UIImage(named: "hub3")!),
                            ItemData(name: "Краснодар", subName: "Более 231 мест", imageCity: UIImage(named: "hub3")!),
                            ItemData(name: "Сочи", subName: "Более 123 мест", imageCity: UIImage(named: "hub3")!),
                            ItemData(name: "Уфа", subName: "Более 156 мест", imageCity: UIImage(named: "hub3")!),
                            ItemData(name: "Пенза", subName: "Более 132 мест", imageCity: UIImage(named: "hub3")!),
                            ItemData(name: "Норильск", subName: "Более 95 мест", imageCity: UIImage(named: "hub3")!),
                            ItemData(name: "Южно-Сахалинск", subName: "Более 123 мест", imageCity: UIImage(named: "hub3")!)]),
        ServiceAuto(titlesec: titleSection(name: "Франция", subName: "Все города"),
                    items: [ItemData(name: "Париж", subName: "Более 112 мест", imageCity: UIImage(named: "hub3")!),
                            ItemData(name: "Ажен", subName: "Более 123 мест", imageCity: UIImage(named: "hub3")!),
                            ItemData(name: "Калаис", subName: "Более 134 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Каен", subName: "Более 154 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Шанелл", subName: "Более 164 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Капентрасс", subName: "Более 131 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Блойс", subName: "Более 141 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Еус", subName: "Более 131 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Метз", subName: "Более 98 мест", imageCity: UIImage(named: "hub3")!)]),
        ServiceAuto(titlesec: titleSection(name: "США", subName: "Все города"),
                    items: [ItemData(name: "Чикаго", subName: "Более 67 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Лос-Анджелес", subName: "Более 87 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Хьюстон", subName: "Более 56 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Финикс", subName: "Более 134 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Филадельфия", subName: "Более 123 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Сан-Антонио", subName: "Более 152 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Сан-Диего", subName: "Более 123 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Даллас", subName: "Более 90 мест", imageCity: UIImage(named: "hub3")!),
                                           ItemData(name: "Сан-Хосе", subName: "Более 87 мест", imageCity: UIImage(named: "hub3")!)]),
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

            sectionHeader.countryNameLabel.text = section.name
            sectionHeader.subTitleLabel.text = section.subName
            return sectionHeader
        }
    }
    
}

extension WorldController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as! SectionHeader
            reusableview.frame = CGRect(x: 0 , y: 0, width: self.view.frame.width, height: 80)

        reusableview.countryNameLabel.text = rentsService[indexPath.section].titlesec.name
        reusableview.subTitleLabel.text = rentsService[indexPath.section].titlesec.subName
        reusableview.delegate = self
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

        cell.configureCell(type: rentsService[indexPath.section].items[indexPath.row].name,
                           name: rentsService[indexPath.section].items[indexPath.row].subName,
                           image: rentsService[indexPath.section].items[indexPath.row].imageCity)
        cell.delegate = self
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

// MARK: - WorldCollectionViewCellDelegate

extension WorldController: WorldCollectionViewCellDelegate {
    func showSelected(show: String) {
        print("Show selected: \(show)")
    }
}

// MARK: - SectionHeaderDelegate

extension WorldController: SectionHeaderDelegate {
    func showCountyToBuy(countryName: String) {
        print("show County To Buy: \(countryName)")
    }
}
