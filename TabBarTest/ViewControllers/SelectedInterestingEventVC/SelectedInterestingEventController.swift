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

class SelectedInterestingEventController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: SelectedInterestingEventBussinessLogic?
    var router: (NSObjectProtocol & SelectedInterestingEventRoutingLogic & SelectedInterestingEventDataPassing)?
    var currentCity: String = ""
    
    // MARK: - Private Properties
    
    private var titleName: String = ""
    var viewModel: SelectedInterestingEventViewModel.EventModels.ViewModel!
    private let userDefault = UserDefaults.standard
    // выбранной ячейки для тапа по описанию, для увеличения высоты ячейки
    private var selectedDescriptionCell: Bool = false
    private struct DescriptionWeather {
        var temp: String
        var feelsLike: String
        var image: UIImage
        var description: String
        var sunrise: String
        var sunset: String
    }
    private var currentWeather: DescriptionWeather!
    private var descriptionHeightCell: CGFloat = 0
    
    
    // MARK: - UI Properties
    
    private let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.isUserInteractionEnabled = false
        return control
    }()
    private let mainTextView: UITextView = {
       let textView = UITextView()
        textView.backgroundColor = .red
        return textView
    }()
    
    
    
    
    
    // MARK: - Public properties
    private let layout = UICollectionViewFlowLayout()
    private lazy var modelImage = [UIImage]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupClean()
        setupUI()
        viewModel =  SelectedInterestingEventViewModel.EventModels.ViewModel(
            event: SelectedInterestingEventViewModel.EventModel(
                mainText: "Выбранное инетересное событие города",
                image: [
                    UIImage(named: "hub3")!,UIImage(named: "hub3")!
                ])
        )
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleName = userDefault.string(forKey: UserDefaults.currentCity) ?? ""
        title = titleName
        // в интеракторе создаем большую модель для заполнения всех ячеек таблицы, заголовка, погоды и всей остальой инфорамции
        //        interactor?.showEvent()
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
        layout.scrollDirection = .horizontal
        collectionView.register(InterestingEventsCollectionViewCell.self,
                                forCellWithReuseIdentifier: InterestingEventsCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        layout.itemSize = CGSize(width: 240, height: 170)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.isPagingEnabled = true
        
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(mainTextView)
        
        collectionView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: mainTextView.topAnchor,
                         right: view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0, height: 240)
        pageControl.anchor(top: nil,
                           left: view.leftAnchor,
                           bottom: view.bottomAnchor,
                           right: view.rightAnchor,
                           paddingTop: 0,
                           paddingLeft: 50,
                           paddingBottom: 20,
                           paddingRight: 50,
                           width: 0,
                           height: 0)
        mainTextView.anchor(top: nil,
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

// MARK: - CountryDisplayLogic

extension SelectedInterestingEventController: SelectedInterestingEventDisplayLogic {
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели
    func displayAllCities(viewModel: SelectedInterestingEventViewModel.EventModels.ViewModel) {
        self.viewModel = viewModel
        mainTextView.text = viewModel.event.mainText
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}


extension SelectedInterestingEventController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = modelImage.count
        pageControl.numberOfPages = count
        pageControl.isHidden = !(count > 1)
        return count
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
    
    // Размер ячейки
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width-32,
//                      height: UIScreen.main.bounds.width-(UIScreen.main.bounds.width/3))
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}






