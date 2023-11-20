//
//  CurrentCityController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol CurrentCityDisplayLogic: AnyObject {
    func displayAllCities(viewModel: CurrentCityViewModel.AllCitiesInCurrentCountry.ViewModel)
    func updateWeather(viewModel: CurrentCityViewModel.WeatherCurrentCountry.ViewModel)
}

class CurrentCityController: UIViewController {
    
    // MARK: - UI Properties
    private let actionsButtonsCityView = ActionsButtonsCityView(frame: CGRect(x: 0,
                                                                              y: 0,
                                                                              width: UIScreen.main.bounds.width,
                                                                              height: 60))
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    // MARK: - Public Properties
    
    var interactor: CurrentCityBussinessLogic?
    var router: (NSObjectProtocol & CurrentCityRoutingLogic & CurrentCityDataPassing)?
    var currentCity: String = ""
    
    // MARK: - Private Properties
    
    private var titleName: String = ""
    
    // MARK: - TODO Удалить когда сделаю загрузку с сервера
    private var sightsArray = [SightsModel]()
    
    private var cityArray: [CityArray] = [
        CityArray(name: "Москва", image: UIImage(named: "moskva")!),
        CityArray(name: "Санкт-Петербург", image: UIImage(named: "spb")!),
        CityArray(name: "Сочи", image: UIImage(named: "sochi")!),
        CityArray(name: "Краснодар", image: UIImage(named: "krasnodar")!),
        CityArray(name: "Гатчина", image: UIImage(named: "gatchina")!),
        CityArray(name: "Купертино", image: UIImage(named: "cupertino")!)]
    
    private var guidesArray: [GuideSightsModel] = [
        GuideSightsModel(image: UIImage(named: "hermitage2")!, name: "Эрмитаж", price: 1060, rating: 4.5, reviews: 79),
        GuideSightsModel(image: UIImage(named: "exhbgrandmaket")!, name: "Гранд Макет Россия", price: 6500, rating: 4.5, reviews: 1231),
        GuideSightsModel(image: UIImage(named: "exhbroof")!, name: "Экскурсия по крышам", price: 5305, rating: 0, reviews: 53),
        GuideSightsModel(image: UIImage(named: "exhblebed")!, name: "Лебединое озеро", price: 2341, rating: 4.2, reviews: 46),
        GuideSightsModel(image: UIImage(named: "exhbrusmuseum")!, name: "Государственный Русский музей", price: 928, rating: 4.1, reviews: 11)
    ]
    
    var viewModel = CurrentCityViewModel.AllCitiesInCurrentCountry.ViewModel(
        weather: CurrentWeatherSevenDays(
            currentWeather: CurrentWeatherOfSevenDays(todayTemp: 0.0,
                                                      imageWeather: UIImage(),
                                                      description: "",
                                                      feelsLike: 0.0,
                                                      sunrise: 0,
                                                      sunset: 0),
            sevenDaysWeather: [WeatherSevenDays(dayOfWeek: 0,
                                                tempFrom: 0.0,
                                                tempTo: 0.0,
                                                image: UIImage(),
                                                description: "")]),
        cities: CurrentCityViewModel.CityModel(name: "", image: UIImage(named: "hub3")!))
    private let userDefault = UserDefaults.standard
    // выбранной ячейки для тапа по описанию, для увеличения высоты ячейки
    private var selectedDescriptionCell: Bool = false
    private var descriptionHeightCell: CGFloat = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .setCustomColor(color: .mainView)
        setupUI()
        // загружаем данные по текущему городу
        interactor?.showCity(lat: 59.9396340, lon: 30.3104843)
        
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
        titleName = userDefault.string(forKey: UserDefaults.currentCity) ?? ""
        title = titleName
        // в интеракторе создаем большую модель для заполнения всех ячеек таблицы, заголовка, погоды и всей остальой инфорамции
        currentCity = titleName
        router?.dataStore?.currentCity = currentCity
    }
    
    // MARK: - Helper Functions
    
    // Настройка архитектуры Clean Swift
    private func setupClean() {
        let viewController = self
        let interactor = CurrentCityInteractor()
        let presenter = CurrentCityPresenter()
        let router = CurrentCityRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.currentCityController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        actionsButtonsCityView.actionButtonDelegate = self
        // скролл картинок
        tableView.register(CountryPhotosTableViewCell.self,
                           forCellReuseIdentifier: CountryPhotosTableViewCell.identifier)
        // описание с кнопкой
        tableView.register(CountryDescriptionTableViewCell.self,
                           forCellReuseIdentifier: CountryDescriptionTableViewCell.identifier)
        // другие города
        tableView.register(CountryCitiesTableViewCell.self,
                           forCellReuseIdentifier: CountryCitiesTableViewCell.identifier)
        // Переиспользуемая для всех интересных мест
        tableView.register(SightTableViewCell.self,
                           forCellReuseIdentifier: SightTableViewCell.identifier)
        // Билеты на экскурсии
        tableView.register(TicketCollectionViewCell.self,
                           forCellReuseIdentifier: TicketCollectionViewCell.identifier)
        // Погода
        tableView.register(WeatherCollectionViewCell.self,
                           forCellReuseIdentifier: WeatherCollectionViewCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: 16, right: 0)
        
        view.addSubviews(actionsButtonsCityView, tableView)
        
        actionsButtonsCityView.anchor(top: view.layoutMarginsGuide.topAnchor,
                                      left: view.leftAnchor,
                                      bottom: nil,
                                      right: view.rightAnchor,
                                      paddingTop: 0,
                                      paddingLeft: 0,
                                      paddingBottom: 0,
                                      paddingRight: 0,
                                      width: 0, height: 60)
        tableView.anchor(top: actionsButtonsCityView.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.layoutMarginsGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0, height: 0)
    }
    
}

// MARK: - CountryDisplayLogic

extension CurrentCityController: CurrentCityDisplayLogic {
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели
    func displayAllCities(viewModel: CurrentCityViewModel.AllCitiesInCurrentCountry.ViewModel) {
        print("displayAllCities viewModel:\(viewModel)")
        
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    // Обновить ячейку погоды после того как произошла загрузка с интернета данных
    func updateWeather(viewModel: CurrentCityViewModel.WeatherCurrentCountry.ViewModel) {
        self.viewModel.weather = viewModel.weather
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadRows(at: [IndexPath(row: 6, section: 0)], with: .automatic)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CurrentCityController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // MARK: - заполнение каждой ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
            // картинки города
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryPhotosTableViewCell.identifier,
                                                           for: indexPath) as? CountryPhotosTableViewCell else { return UITableViewCell() }
            cell.configureCell(cityImages: ["spb1", "spb2", "spb3", "spb4", "spb5"])
            return cell
            
            // описание
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryDescriptionTableViewCell.identifier,
                                                           for: indexPath) as? CountryDescriptionTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configureCell(titleName: "Описание города", description: "Санкт-Петербург – русский портовый город на побережье Балтийского моря, который в течение двух веков служил столицей Российской империи. Он был основан в 1703 году Петром I, которому воздвигнут знаменитый памятник Медный всадник. Город по праву считается культурным центром страны. Санкт-Петербург – русский портовый город на побережье Балтийского моря, который в течение двух веков служил столицей Российской империи. Он был основан в 1703 году Петром I, которому воздвигнут знаменитый памятник Медный всадник. Город по праву считается культурным центром страны.")
            selectedDescriptionCell
                ? cell.moreButtons.setTitle(Constants.Cells.hideDescription, for: .normal)
                : cell.moreButtons.setTitle(Constants.Cells.readMore, for: .normal)
            return cell
            
            // Интересные места по близости
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier,
                                                           for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.configureCell(model: sightsArray,
                               title: Constants.Cells.sightNearMe,
                               size: CGSize(width: 230, height: 190))
            return cell
            
            // Обязательно к просмотру
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier,
                                                           for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configureCell(model: sightsArray,
                               title: Constants.Cells.mustSeeSights,
                               size: CGSize(width: 230, height: 190))
            return cell
            
            // Билеты на экскурсии
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TicketCollectionViewCell.identifier,
                                                           for: indexPath) as? TicketCollectionViewCell else { return UITableViewCell() }
            cell.model = guidesArray
            cell.delegate = self
            return cell
            
            // Погода
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else { return UITableViewCell() }
            cell.configureCell(city: titleName,
                               curTemp: Int(viewModel.weather.currentWeather.todayTemp),
                               curImage: viewModel.weather.currentWeather.imageWeather,
                               description: viewModel.weather.currentWeather.description,
                               feelLike: Int(viewModel.weather.currentWeather.feelsLike),
                               sunrise: viewModel.weather.currentWeather.sunrise,
                               sunset: viewModel.weather.currentWeather.sunset)
            cell.delegate = self
            return cell
            
            // Выбор редакции
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier, for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.configureCell(model: sightsArray,
                               title: Constants.Cells.chooseOfRedaction,
                               size: CGSize(width: 230, height: 180))
            return cell
            
            // Музеи
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier,
                                                           for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configureCell(model: sightsArray,
                               title: Constants.Cells.museums,
                               size: CGSize(width: 230, height: 180))
            return cell
            
            // Парки
        case 8:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier,
                                                           for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configureCell(model: sightsArray,
                               title: Constants.Cells.parks,
                               size: CGSize(width: 230, height: 180))
            return cell
            
            // другие города
        case 9:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCitiesTableViewCell.identifier,
                                                           for: indexPath) as? CountryCitiesTableViewCell else { return UITableViewCell() }
            cell.model = cityArray
            cell.delegate = self
            return cell
            
        default: return UITableViewCell()
        }
        
    }
    // MARK: - высота каждой ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            
            // ячейка с картинками текущего города
        case 0: return UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3) + 32
            
            // ячейка с описанием города
        case 1: return selectedDescriptionCell ? descriptionHeightCell : 200

            // места в окрестностях
        case 2: return 240
            
            // обязательно к просмотру
        case 3: return 240
            
            // Билеты на экскурсии
        case 4: return 315
            
            // Погода
        case 5: return 256

            // Выбор редакции
        case 6: return 240
            
            // Музеи
        case 7: return 240
            
            // Парки
        case 8: return 240
            
            // другие города
        case 9: return 320
            
        default: return 50
        }
    }
}

// MARK: - CountryDescriptionTableViewCellDelegate

extension CurrentCityController: CountryDescriptionTableViewCellDelegate {
    // определяем высоту для расширенной ячейки описание города
    func heightCell(height: CGFloat) {
        let standartHeightDataOfCell: CGFloat = 100
        descriptionHeightCell = height + standartHeightDataOfCell
    }
    
    // показываем больше текста в описании (расширяем таблицу)
    func showMoreText() {
        selectedDescriptionCell = !selectedDescriptionCell
        tableView.reloadData()
    }
}

// MARK: - CountryCitiesTableViewCellDelegate

extension CurrentCityController: CountryCitiesTableViewCellDelegate {
    // Открываем другой город из текущего
    func showSelectedCityDescription(_ name: String) {
        currentCity = name
        print("open currentCity:\(currentCity)")
        router?.dataStore?.currentCity = currentCity
        router?.routeToCityVC()
    }
    
    // открываем выбранный город на карте
    func showSelectedCityOnMap(_ lat: Double, _ lon: Double) {
        userDefault.set(true, forKey: UserDefaults.showSelectedCity)
        userDefault.set(lat, forKey: UserDefaults.showSelectedCityWithLatitude)
        userDefault.set(lon, forKey: UserDefaults.showSelectedCityWithLongitude)
        tabBarController?.selectedIndex = 0
    }
}

// MARK: - SightTableViewCellDelegate

extension CurrentCityController: SightTableViewCellDelegate {
    // нажатие на кнопку смотреть все из "места в окрестностях"
    func lookAll() {
        print("Нажатие кнопки 'см.все'")
    }
    
    // открываем выбранную достопримечательность на карте
    func handleSelectedSight(_ name: String) {
        userDefault.set(true, forKey: UserDefaults.showSelectedSight)
        userDefault.set(name, forKey: UserDefaults.showSelectedSightName)
        tabBarController?.selectedIndex = 0
    }
}

// MARK: - WeatherCollectionViewCellDelegate

extension CurrentCityController: WeatherCollectionViewCellDelegate {
    func showFullWeather() {
        router?.routeToFullWeatherVC()
    }
}

// MARK: - ActionsButtonsCityViewDelegate

extension CurrentCityController: ActionsButtonsCityViewDelegate {
    func favouriteButtonTapped() {
        router?.routeToFavouritesVC()
    }
    
    func interestingButtonTapped() {
        router?.routeToInterestingEventsVC()
    }
    
    func faqButtonTapped() {
        router?.routeToFAQVC()
    }
    
    
}

// MARK: - TicketCollectionViewCellDelegate

extension CurrentCityController: TicketCollectionViewCellDelegate {
    
    // открыть страницу всех билетов
    func lookAllTickets() {
        print("открыть страницу всех билетов")
    }
}

