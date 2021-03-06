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
    
    
    // MARK: - UI Properties
    
    private let collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: UICollectionViewLayout.init())
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.init(name: "GillSans-Semibold", size: 15)
        label.text = "00-00-0000"
        return label
    }()
    private let mainTextView: UITextView = {
       let textView = UITextView()
        textView.backgroundColor = .white
        textView.isUserInteractionEnabled = false
        textView.font = UIFont.init(name: "GillSans-Regular", size: 15)
        return textView
    }()

    // MARK: - Public properties
    private let layout = UICollectionViewFlowLayout()
    private lazy var modelImage = [UIImage]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
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
    
    // ?????????????????? ?????????????????????? Clean Swift
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
        layout.itemSize = CGSize(width: 220, height: 170)
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        view.addSubview(collectionView)
        view.addSubview(mainTextView)
        view.addSubview(dateLabel)
        
        collectionView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: dateLabel.topAnchor,
                         right: view.rightAnchor,
                         paddingTop: 16,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0, height: 280)
        dateLabel.anchor(top: nil,
                          left: view.leftAnchor,
                          bottom: mainTextView.topAnchor,
                          right: view.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 16,
                          paddingBottom: 0,
                          paddingRight: 16,
                          width: 0, height: 25)
        mainTextView.anchor(top: nil,
                            left: view.leftAnchor,
                            bottom: view.bottomAnchor,
                            right: view.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 14,
                            paddingBottom: 14,
                            paddingRight: 14,
                            width: 0, height: 0)
    }
    
    
}

// MARK: - CountryDisplayLogic

extension SelectedInterestingEventController: SelectedInterestingEventDisplayLogic {
    // ?????????????????????? ?????????????????????? ?????????????? ?????????? ???????????????????? ?? ?????????????????????? ?????????????? ????????????
    // ???????? ?????? ???? ???????????????? ??.?? ???????? ????????????
    func displayAllCities(viewModel: SelectedInterestingEventViewModel.EventModels.ViewModel) {
        self.viewModel = viewModel
        title = viewModel.event.nameEvent
        modelImage = viewModel.event.image
        mainTextView.text = viewModel.event.mainText
        dateLabel.text = viewModel.event.date
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}


extension SelectedInterestingEventController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestingEventsCollectionViewCell.identifier, for: indexPath) as? InterestingEventsCollectionViewCell else { return UICollectionViewCell() }
        cell.conigureCell(image: modelImage[indexPath.row])
        return cell
    }
    
    // ?????????????? ???? ?????????? ???????????? ???? ?????????????? ??????????????
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    // ???????????????????? ?????????? ???????????????? - ?????????? ????????????
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}






