//
//  UnboardingController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 07.12.2023.
//

import UIKit
import SnapKit

protocol UnboardingDisplayLogic: AnyObject {
    func displayUnboarding(viewModel: UnboardingModels.Unboarding.ViewModel)
}

// MARK: - Экран погоды

class UnboardingController: UIViewController {

    // MARK: - UI properties
    
    private var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        return view
    }()
    
    private var backgroundTextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private var imagesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()
    
    private var swiperPanelOnScrollViewView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .setCustomColor(color: .titleText)
        label.font = .setCustomFont(name: .bold, andSize: 30)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .setCustomColor(color: .titleText)
        label.font = .setCustomFont(name: .regular, andSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var nextView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var nextTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .setCustomColor(color: .titleText)
        label.font = .setCustomFont(name: .bold, andSize: 20)
        label.textAlignment = .right
        return label
    }()
    
    private var countPagesPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        pageControl.contentMode = .scaleToFill
        pageControl.contentHorizontalAlignment = .left
        pageControl.contentVerticalAlignment = .center
        return pageControl
    }()
    
    // MARK: - Private Properties
 
    private var scrollViewHeightConstraint: CGFloat = 0
    private var lastContentOffset: CGFloat = 0.0
    private var currentPage: Int = 0
    private var model: UnboardingModels.Unboarding.ViewModel!
    
    // MARK: - Public Properties
    
    var interactor: UnboardingBussinessLogic?
    var router: (NSObjectProtocol & UnboardingRoutingLogic & UnboardingDataPassing)?
//    var viewModel: UnboardingModels.Unboarding.ViewModel!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .white
        setupConstraints()
        swipeRegister()
        interactor?.showUnboarding()
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
        let interactor = UnboardingInteractor()
        let presenter = UnboardingPresenter()
        let router = UnboardingRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.unboardingController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    // MARK: - Helper functions
    
    private func setupUI() {
        UserDefaults.standard.setValue(true, forKey: UserDefaults.firstOpenApp)
        
        // Включение показа предыдущего экрана по свайпу
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.navigationBar.isHidden = true
        let currentModel = model.model[currentPage]
        mainView.backgroundColor = UIColor(named: currentModel.backgroundColor) 
        titleLabel.text = currentModel.title
        subTitleLabel.text = currentModel.subTitle
        nextTitleLabel.text = currentModel.nextButtonTitle
        countPagesPageControl.isUserInteractionEnabled = false
        countPagesPageControl.currentPage = currentPage
        countPagesPageControl.currentPageIndicatorTintColor = .darkGray
        countPagesPageControl.pageIndicatorTintColor = .lightGray
    }
    
    // Настраиваем положения и размеры скролла и отступы от кнопки "далее"
    private func setupConstraints() {
        view.addSubviews(mainView)
        
        mainView.addSubviews(backgroundTextImageView,
                             imagesScrollView,
                             swiperPanelOnScrollViewView,
                             titleLabel,
                             subTitleLabel,
                             nextView,
                             countPagesPageControl)
        nextView.addSubviews(nextTitleLabel)
        
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        backgroundTextImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(80)
        }
        
        imagesScrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(80)
            $0.height.equalTo(327)
        }
        
        swiperPanelOnScrollViewView.snp.makeConstraints {
            $0.edges.equalTo(imagesScrollView.snp.edges)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundTextImageView.snp.bottom)
            $0.top.greaterThanOrEqualTo(imagesScrollView.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        nextView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(49)
        }
        
        nextTitleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        countPagesPageControl.snp.makeConstraints {
            $0.centerY.equalTo(nextView.snp.centerY)
            $0.leading.equalToSuperview().offset(-12)
        }
        
        let heightOfOtherElement: CGFloat = 325
        let spacingNextButton: CGFloat = 113
        if UIScreen.main.bounds.height - heightOfOtherElement - spacingNextButton < 300 {
            
            nextView.snp.remakeConstraints {
                $0.top.equalTo(subTitleLabel.snp.bottom).offset(16)
                $0.trailing.equalToSuperview().inset(24)
                $0.leading.equalToSuperview().offset(249)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            }
            
            scrollViewHeightConstraint = UIScreen.main.bounds.height - heightOfOtherElement - 20 - 16
            
            imagesScrollView.snp.remakeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalToSuperview().offset(80)
                $0.height.equalTo(scrollViewHeightConstraint)
            }
        } else {
            scrollViewHeightConstraint = UIScreen.main.bounds.height - heightOfOtherElement - spacingNextButton
            
            imagesScrollView.snp.remakeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalToSuperview().offset(80)
                $0.height.equalTo(scrollViewHeightConstraint)
            }
        }
        
        
    }
    
    // Регистрация свайпов
    private func swipeRegister() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeAction))
        leftSwipe.direction = .left
        leftSwipe.numberOfTouchesRequired = 1
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeAction))
        rightSwipe.direction = .right
        rightSwipe.numberOfTouchesRequired = 1
        
        mainView.addGestureRecognizer(rightSwipe)
        mainView.addGestureRecognizer(leftSwipe)
        mainView.isUserInteractionEnabled = true
        
        let nextTap = UITapGestureRecognizer(target: self, action: #selector(leftSwipeAction))
        nextView.addGestureRecognizer(nextTap)
        nextView.isUserInteractionEnabled = true
    }
    
    // Загружаем картинки в скролл вью
    private func setupImages() {
        for i in 0..<model.model.count {
            let imageView = UIImageView()
            imageView.clipsToBounds = false
            imageView.image = model.model[i].mainImage
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            var heightScrollView = scrollViewHeightConstraint
            if heightScrollView < imagesScrollView.bounds.height {
                heightScrollView = imagesScrollView.bounds.height
            }
            imageView.frame = CGRect(x: xPosition,
                                     y: -15,
                                     width: UIScreen.main.bounds.width,
                                     height: heightScrollView + 35)
            imageView.contentMode = .scaleAspectFit
            imagesScrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
            imagesScrollView.addSubview(imageView)
            imagesScrollView.delegate = self
        }
    }
    
    // Обновление контента при скроле или тыке на экран
    private func updateScroll(_ scrollView: UIScrollView, nextScreen: Bool? = nil) {
        let contentSize: CGSize = scrollView.contentSize
        let contentOffset: CGPoint = scrollView.contentOffset
        let frame: CGRect = scrollView.frame
        let contentInset: UIEdgeInsets = scrollView.contentInset
        
        if contentOffset.y > 0 || contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
        
        let maximumHorizontalOffset: CGFloat = contentSize.width - frame.width
        let currentHorizontalOffset: CGFloat = contentOffset.x
        
        let maximumVerticalOffset: CGFloat = contentSize.height - frame.height
        let currentVerticalOffset: CGFloat = contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset,
                                             y: percentageVerticalOffset)
        
        UIView.animate(withDuration: 0.35) {
            if let nextScreen = nextScreen {
                if nextScreen {
                    scrollView.contentOffset.x = contentOffset.x + frame.width
                } else {
                    scrollView.contentOffset.x = contentOffset.x - frame.width
                }
            }
            if percentOffset.x < 0 {
                scrollView.contentOffset.x = -contentInset.left
            }
            if percentOffset.x > 1 {
                scrollView.contentOffset.x = contentSize.width - scrollView.bounds.width + contentInset.right
            }
        }
    }
    
    // MARK: - Selectors

    
    // Свайп влево или нажатие на кнопку далее
    @objc private func leftSwipeAction() {
        if currentPage != model.model.count-1 {
            currentPage += 1
            updateScroll(imagesScrollView, nextScreen: true)
            setupUI()
        } else {
            router?.routeToMapVC()
        }
    }
    
    // Свайп вправо
    @objc private func rightSwipeAction() {
        if currentPage > 0 {
            currentPage -= 1
            updateScroll(imagesScrollView, nextScreen: false)
            setupUI()
        }
    }
}


// MARK: - UnboardingDisplayLogic

extension UnboardingController: UnboardingDisplayLogic {
    
    func displayUnboarding(viewModel: UnboardingModels.Unboarding.ViewModel) {
        self.model = viewModel
        setupImages()
        setupUI()
    }
}

// MARK: - UIScrollViewDelegate

extension UnboardingController: UIScrollViewDelegate {
    
}
