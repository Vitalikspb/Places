//
//  RentAutoController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol RentAutoDisplayLogic: AnyObject {
    func displayRentAuto(viewModel: RentAutoModels.RentAuto.ViewModel)
}

class RentAutoController: UIViewController {
    
    // MARK: - UI Properties
    
    private let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    private lazy var collectionView: UICollectionView! = nil
    
    
    // MARK: - Public Properties
    
    var dataSource: UICollectionViewDiffableDataSource<RentAutoModels.TitleSection, RentAutoModels.AutoModel>?
    
    var interactor: RentAutoBussinessLogic?
    var router: (NSObjectProtocol & RentAutoRoutingLogic & RentAutoDataPassing)?
    var viewModel: RentAutoModels.RentAuto.ViewModel!
    private let layout = UICollectionViewFlowLayout()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        
        interactor?.showRentAuto()
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
    
    // MARK: - Helper Functions
    
    // Настройка архитектуры Clean Swift
    private func setupClean() {
        let viewController = self
        let interactor = RentAutoInteractor()
        let presenter = RentAutoPresenter()
        let router = RentAutoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.rentAutoController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(SectionHeaderRentAuto.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderRentAuto.reuseIdentifier)
        collectionView.register(RentAutoCollectionViewCell.self,
                                forCellWithReuseIdentifier: RentAutoCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
        view.addSubview(topSeparator)
        
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
        collectionView.anchor(top: topSeparator.bottomAnchor,
                              left: view.leftAnchor,
                              bottom: view.bottomAnchor,
                              right: view.rightAnchor,
                              paddingTop: 10,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0, height: 0)
        
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderRentAuto.reuseIdentifier, for: indexPath) as? SectionHeaderRentAuto else {
                return nil
            }
            
            guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return nil }
            if section.title.isEmpty { return nil }
            
            sectionHeader.titleLabel.text = section.title
            return sectionHeader
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension RentAutoController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0
            ? viewModel.rentsService.first?.rents.count ?? 0
            : viewModel.rentsService.last?.rents.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RentAutoCollectionViewCell.identifier, for: indexPath) as? RentAutoCollectionViewCell else { return UICollectionViewCell() }
        
        let modelRent = viewModel.rentsService.first?.rents[indexPath.row]
        let modelTaxi = viewModel.rentsService.last?.rents[indexPath.row]
        
        switch indexPath.section {
        case 0: cell.configureCell(title: modelRent?.name ?? "", image: modelRent?.image ?? UIImage())
        case 1: cell.configureCell(title: modelTaxi?.name ?? "", image: modelTaxi?.image ?? UIImage())
        default: break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        indexPath.section == 0
//            ?
//            print("выбран: \(viewModel.rentsService.first?.rents[indexPath.row].name)")
//            :
//            print("выбран: \(viewModel.rentsService.last?.rents[indexPath.row].name)")
    }
}








extension RentAutoController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableview = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderRentAuto.reuseIdentifier, for: indexPath) as! SectionHeaderRentAuto
        reusableview.frame = CGRect(x: 0 , y: 0, width: self.view.frame.width, height: 80)
        
        reusableview.titleLabel.text = indexPath.section == 0
            ? viewModel.rentsService.first?.titlesec.title ?? ""
            : viewModel.rentsService.last?.titlesec.title ?? ""
        
        return reusableview
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: SectionHeaderRentAuto.reuseIdentifier, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - CountryDisplayLogic

extension RentAutoController: RentAutoDisplayLogic {
    // показ информации о текущем городе
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели
    func displayRentAuto(viewModel: RentAutoModels.RentAuto.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}
