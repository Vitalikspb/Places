//
//  WeatherController.swift
//  TabBarTest
//
//  Created by ViceCode on 21.12.2021.
//

import UIKit

protocol WeatherDisplayLogic: AnyObject {
    func displayWeather(viewModel: WeatherModels.Weather.ViewModel)
}

class WeatherController: UIViewController {

    
    // MARK: - UI Properties
    
    private let topSeparator: UIView = {
       let view = UIView()
        view.backgroundColor = .setCustomColor(color: .separatorAppearanceViewNonChanged)
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let headerFullWeather = HeaderFullWeather(frame: CGRect(x: 0,
                                                                    y: 0,
                                                                    width: UIScreen.main.bounds.width,
                                                                    height: 296))
    
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    
    // MARK: - Public Properties
    
    var interactor: WeatherBussinessLogic?
    var router: (NSObjectProtocol & WeatherRoutingLogic & WeatherDataPassing)?
    var viewModel: WeatherModels.Weather.ViewModel!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        
        interactor?.showWeather()
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
        let interactor = WeatherInteractor()
        let presenter = WeatherPresenter()
        let router = WeatherRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.weatherController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        tableView.register(FullWeatherTableViewCell.self,
                           forCellReuseIdentifier: FullWeatherTableViewCell.identifier)
        headerFullWeather.configureUI(title: viewModel.currentCity,
                                      curTemp: "\(Int(viewModel.weather.currentWeather.todayTemp))",
                                      curImage: viewModel.weather.currentWeather.imageWeather,
                                      description: viewModel.weather.currentWeather.description,
                                      feelsLike: "\(Int(viewModel.weather.currentWeather.feelsLike))",
                                      sunrise: "\(viewModel.weather.currentWeather.sunrise)",
                                      sunset: "\(viewModel.weather.currentWeather.sunset)")
        
        tableView.contentInset = UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .setCustomColor(color: .weatherTableViewBackground)
        tableView.allowsSelection = false
        
        view.addSubviews(headerFullWeather, tableView, topSeparator)
        
        topSeparator.centerX(inView: view)
        headerFullWeather.anchor(top: view.topAnchor,
                                 left: view.leftAnchor,
                                 bottom: nil,
                                 right: view.rightAnchor,
                                 paddingTop: 0,
                                 paddingLeft: 0,
                                 paddingBottom: 0,
                                 paddingRight: 0,
                                 width: UIScreen.main.bounds.width, height: 296)
        
        topSeparator.anchor(top: view.topAnchor,
                            left: nil,
                            bottom: nil,
                            right: nil,
                            paddingTop: 8,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 72, height: 4)
        
        tableView.anchor(top: headerFullWeather.bottomAnchor,
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

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension WeatherController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weather.sevenDaysWeather.count
    }
    
    // MARK: - заполнение каждой ячейки
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FullWeatherTableViewCell.identifier, for: indexPath) as? FullWeatherTableViewCell else { return UITableViewCell() }
        cell.configureCell(day: viewModel.weather.sevenDaysWeather[indexPath.row].dayOfWeek,
                           minTemp: Int(viewModel.weather.sevenDaysWeather[indexPath.row].tempFrom),
                           maxTemp: Int(viewModel.weather.sevenDaysWeather[indexPath.row].tempTo),
                           image: viewModel.weather.sevenDaysWeather[indexPath.row].image,
                           description: viewModel.weather.sevenDaysWeather[indexPath.row].description)

        return cell
    }
    
    // Высота каждой ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - CountryDisplayLogic
extension WeatherController: WeatherDisplayLogic {
    // показ информации о текущем городе
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели
    func displayWeather(viewModel: WeatherModels.Weather.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}
