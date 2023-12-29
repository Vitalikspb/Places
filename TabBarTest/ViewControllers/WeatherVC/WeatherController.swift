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

// MARK: - Экран погоды

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
        let modelWeather = viewModel.weather.currentWeather
        headerFullWeather.configureUI(title: viewModel.currentCity,
                                      curTemp: "\(Int(modelWeather.todayTemp))",
                                      curImage: modelWeather.imageWeather,
                                      description: describeWeatherDescription(name: modelWeather.description),
                                      feelsLike: "\(Int(modelWeather.feelsLike))",
                                      sunrise: "\(modelWeather.sunrise)",
                                      sunset: "\(modelWeather.sunset)")
        
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

    // Перевод английских название погоды 
    private func describeWeatherDescription(name: String) -> String {
        switch name.lowercased() {
        case "thunderstorm with light rain":
            return "Гроза с небольшим дождём"
            
        case "thunderstorm with rain": 
            return "Гроза с дождем"
            
        case "thunderstorm with heavy rain":
            return "Гроза с сильным дождем»"
            
        case "light thunderstorm":
            return "Легкая гроза"
            
        case "thunderstorm":
            return "Гроза"
            
        case "heavy thunderstorm":
            return "Сильная гроза"
            
        case "ragged thunderstorm":
            return "Порывистая гроза"
            
        case "thunderstorm with light drizzle":
            return "Гроза с мелкой моросью"
            
        case "thunderstorm with drizzle":
            return "Гроза с моросью"
            
        case "thunderstorm with heavy drizzle":
            return "Гроза с сильным моросящим дождём"
            
        case "light intensity drizzle":
            return "Морось слабой интенсивности"
            
        case "drizzle":
            return "Морось"
            
        case "heavy intensity drizzle":
            return "Сильный дождь"
            
        case "light intensity drizzle rain":
            return "Моросящий дождь слабой интенсивности"
            
        case "drizzle rain":
            return "Моросящий дождь"

        case "heavy intensity drizzle rain":
            return "Сильный моросящий дождь"
            
        case "shower rain and drizzle":
            return "Ливневый дождь и морось"
            
        case "heavy shower rain and drizzle":
            return "Сильный ливень с моросью"
            
        case "shower drizzle":
            return "Дождь и морось"
            
        case "light rain":
            return "Легкий дождь"
            
        case "moderate rain":
            return "Умеренный дождь"
            
        case "heavy intensity rain":
            return "Сильный дождь"
            
        case "very heavy rain":
            return "Очень сильный дождь"
            
        case "extreme rain":
            return "Экстримальный дождь"
            
        case "freezing rain":
            return "Ледяной дождь"
            
        case "light intensity shower rain":
            return "Ливень слабой интенсивности"
            
        case "shower rain":
            return "Проливной дождь"
            
        case "heavy intensity shower rain":
            return "Сильный ливень"
            
        case "ragged shower rain":
            return "Рваный проливной-дождь"
            
        case "light snow":
            return "Легкий снег"
            
        case "snow":
            return "Снег"
            
        case "heavy snow":
            return "Сильный снег"
            
        case "sleet":
            return "Мокрый снег"
            
        case "light shower sleet":
            return "Легкий мокрый снег с дождем"
            
        case "shower sleet":
            return "Дождевая слякоть"
            
        case "light rain and snow":
            return "Легкий дождь и снег"
            
        case "rain and snow":
            return "Дождь и снег"
            
        case "light shower snow":
            return "Легкий снегопад"
            
        case "shower snow":
            return "Снегопад"
            
        case "heavy shower snow":
            return "Сильный снегопад"
            
        case "mist":
            return "Туман"
            
        case "smoke":
            return "Дым"
            
        case "haze":
            return "Дымка"

        case "sand/dust whirls":
            return "Песок/пыль вихри"
            
        case "fog":
            return "Туман"
            
        case "sand":
            return "Песок"
            
        case "dust":
            return "Пыль"
            
        case "volcanic ash":
            return "Вулканический пепел"
            
        case "squalls":
            return "Шквалистая"
            
        case "tornado":
            return "Торнадо"
            
        case "clear sky":
            return "Чистое небо"
            
        case "few clouds", "few clouds: 11-25%":
            return "Мало облаков"
            
        case "scattered clouds", "scattered clouds: 25-50%":
            return "Рассеянные облака"
            
        case "broken clouds", "broken clouds: 51-84%":
            return "Разрывные облака"
            
        case "overcast clouds", "overcast clouds: 85-100%":
            return "Пасмурная облачность"
            
        default: return name
        }
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
        let model = viewModel.weather.sevenDaysWeather[indexPath.row]
        cell.configureCell(day: model.dayOfWeek,
                           minTemp: Int(model.tempFrom),
                           maxTemp: Int(model.tempTo),
                           image: model.image,
                           description: describeWeatherDescription(name: model.description))
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
