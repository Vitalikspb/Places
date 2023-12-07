//
//  UnboardingController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 07.12.2023.
//

import UIKit

protocol UnboardingDisplayLogic: AnyObject {
    func displayUnboarding(viewModel: UnboardingModels.Unboarding.ViewModel)
}

// MARK: - Экран погоды

class UnboardingController: UIViewController {

    
    // MARK: - UI Properties
 
    
    // MARK: - Public Properties
    
    var interactor: UnboardingBussinessLogic?
    var router: (NSObjectProtocol & UnboardingRoutingLogic & UnboardingDataPassing)?
    var viewModel: UnboardingModels.Unboarding.ViewModel!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .white
        interactor?.showUnboarding()
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
    
    private func setupUI() {
        UserDefaults.standard.setValue(true, forKey: UserDefaults.firstOpenApp)
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.router?.routeToMapVC()
        }
    }
}


// MARK: - UnboardingDisplayLogic

extension UnboardingController: UnboardingDisplayLogic {
    
    func displayUnboarding(viewModel: UnboardingModels.Unboarding.ViewModel) {
        print("UnboardingController + displayUnboarding viewModel:\(viewModel)")
    }
    
  
}
