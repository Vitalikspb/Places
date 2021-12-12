//
//  CityController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol CityDisplayLogic: AnyObject {
    func displayCurrentCity(viewModel: String)
}

class CityController: UIViewController {

    
    // MARK: - Public Properties
    
    var interactor: CityBussinessLogic?
    var router: (NSObjectProtocol & CityRoutingLogic & CityDataPassing)?
    var viewModel: String = ""
    
    //MARK: - Private properties
    
    private var titleName: String = ""

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        setupUI()
        interactor?.showCity()
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupClean()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupClean()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    // MARK: - Helper Functions
    
    // Настройка архитектуры Clean Swift
    private func setupClean() {
        let viewController = self
        let interactor = CityInteractor()
        let presenter = CityPresenter()
        let router = CityRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.CityController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUserDefault() {
        
    }
    
    private func setupUI() {

    }
}

// MARK: - CountryDisplayLogic
extension CityController: CityDisplayLogic {
    // показ информации о текущем городе
    func displayCurrentCity(viewModel: String) {
        title = viewModel
    }
}
