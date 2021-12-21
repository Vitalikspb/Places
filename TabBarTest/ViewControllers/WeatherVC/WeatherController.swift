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
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    private let headerFullWeather = HeaderFullWeather()
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
    
    private func setupUserDefault() {
        
    }
    
    private func setupUI() {
        tableView.register(FullWeatherTableViewCell.self,
                           forCellReuseIdentifier: FullWeatherTableViewCell.identifier)
        headerFullWeather.configureUI(title: viewModel.currentCity,
                                      today: "\(viewModel.weather.currentWeather.todayTemp)",
                                      curTemp: "\(viewModel.weather.currentWeather.todayTemp)",
                                      curImage: viewModel.weather.currentWeather.imageWeather,
                                      description: viewModel.weather.currentWeather.description,
                                      feelsLike: "\(viewModel.weather.currentWeather.feelsLike)",
                                      sunrise: "\(viewModel.weather.currentWeather.sunrise)",
                                      sunset: "\(viewModel.weather.currentWeather.sunset)")
        tableView.tableHeaderView = headerFullWeather
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        view.addSubview(topSeparator)
        view.addSubview(tableView)
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
        tableView.anchor(top: topSeparator.bottomAnchor,
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
                           minTemp: viewModel.weather.sevenDaysWeather[indexPath.row].tempFrom,
                           maxTemp: viewModel.weather.sevenDaysWeather[indexPath.row].tempTo,
                           image: viewModel.weather.sevenDaysWeather[indexPath.row].image,
                           description: viewModel.weather.sevenDaysWeather[indexPath.row].description)
        return cell
    }
    
    // Высота каждой ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    
    // Белое заполнение пустой части таблицы
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
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
