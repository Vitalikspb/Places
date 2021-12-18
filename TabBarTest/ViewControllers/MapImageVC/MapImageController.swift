//
//  MapImageController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.12.2021.
//

import UIKit

protocol MapImageDisplayLogic: AnyObject {
    func displayMapImage(viewModel: MapImageModels.MapImageModel.ViewModel)
}

class MapImageController: UIViewController {

    
    // MARK: - UI Properties
    private var imageScrollView: ImageScrollView = {
       let imageScroll = ImageScrollView()
        return imageScroll
    }()
    
    // MARK: - Public Properties
    
    var interactor: MapImageBussinessLogic?
    var router: (NSObjectProtocol & MapImageRoutingLogic & MapImageDataPassing)?
    var viewModel: MapImageModels.MapImageModel.ViewModel!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        
        interactor?.showMapImage()
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
        let interactor = MapImageInteractor()
        let presenter = MapImagePresenter()
        let router = MapImageRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.mapImageController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        imageScrollView = ImageScrollView(frame: view.bounds)
        view.addSubview(imageScrollView)
        imageScrollView.addConstraintsToFillView(view: view)
        imageScrollView.set(image: self.viewModel.mapImage)
    }
}

// MARK: - CountryDisplayLogic
extension MapImageController: MapImageDisplayLogic {
    func displayMapImage(viewModel: MapImageModels.MapImageModel.ViewModel) {
        self.viewModel = viewModel
        title = self.viewModel.nameOfMap

    }
}
