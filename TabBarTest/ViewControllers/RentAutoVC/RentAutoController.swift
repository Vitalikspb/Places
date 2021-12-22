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
    private let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    
    
    // MARK: - Public Properties
    
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
    
    private func setupUserDefault() {
        
    }
    
    private func setupUI() {
        layout.scrollDirection = .horizontal
        collectionView.register(RentAutoCollectionViewCell.self,
                                forCellWithReuseIdentifier: RentAutoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        layout.itemSize = CGSize(width: 220, height: 170)
        collectionView.setCollectionViewLayout(layout, animated: true)
        
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
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension RentAutoController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? viewModel.rentsService.rents.count : viewModel.rentsService.taxi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RentAutoCollectionViewCell.identifier, for: indexPath) as? RentAutoCollectionViewCell else { return UICollectionViewCell() }
        
        let modelRent = viewModel.rentsService.rents[indexPath.row]
        let modelTaxi = viewModel.rentsService.taxi[indexPath.row]
        
        switch indexPath.section {
        case 0: cell.configureCell(title: modelRent.name, image: modelRent.image)
        case 1: cell.configureCell(title: modelTaxi.name, image: modelTaxi.image)
        default: break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexPath.section == 0
        ?
        print("выбран: \(viewModel.rentsService.rents[indexPath.row].name)")
        :
        print("выбран: \(viewModel.rentsService.taxi[indexPath.row].name)")
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
