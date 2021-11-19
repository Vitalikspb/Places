////
////  CityController.swift
////  TabBarTest
////
////  Created by VITALIY SVIRIDOV on 13.11.2021.
////
//
import UIKit
//
//protocol CityDisplayLogic: AnyObject {
//    func displayCurrentCity(viewModel: CityViewModel.CurrentCity.ViewModel)
//}
//
class CityController: UIViewController {
}
//    
//    // MARK: - Public Properties
//    
//    var interactor: CityBussinessLogic?
//    var router: (NSObjectProtocol & CityRoutingLogic & CityDataPassing)?
//    
//    private var titleName: String = ""
//    var viewModel: [CityViewModel.CityModel]!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationController?.navigationBar.isHidden = false
//        view.backgroundColor = .white
//        setupClean()
//        setupUI()
//        viewModel =  [CityViewModel.CityModel(title: "",
//                                              image: UIImage(named: "new-york")!)]
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupClean()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        viewModel.removeAll()
//        interactor?.showCity()
//    }
//
//    // MARK: - Helper Functions
//    
//    // Настройка архитектуры Clean Swift
//    private func setupClean() {
//        let viewController = self
//        let interactor = CityInteractor()
//        let presenter = CityPresenter()
//        let router = CityRouter()
//        viewController.interactor = interactor
//        viewController.router = router
//        interactor.presenter = presenter
//        presenter.CityController = viewController
//        router.viewController = viewController
////        router.dataStore = interactor
//    }
//    
//    private func setupUserDefault() {
//        
//    }
//    
//    private func setupUI() {
//
//    }
//}
//
//// MARK: - CountryDisplayLogic
//extension CityController: CityDisplayLogic {
//    // показ информации о текущем городе
//    func displayCurrentCity(viewModel: CityViewModel.CurrentCity.ViewModel) {
//        title = viewModel.city.title
//    }
//}
