//
//  CityController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit
import CoreLocation

protocol CityDisplayLogic: AnyObject {
    func displayCurrentCity(viewModelWeather: CityViewModel.CurrentCity.ViewModel, viewModelCityData: CityViewModel.AllCountriesInTheWorld.ViewModel, viewModelSightData: [SightsModel])
    func updateWeather(viewModel: CityViewModel.CurrentCity.ViewModel)
}

class CityController: UIViewController {
    
    
    // MARK: - UI Properties
    
    private let actionsButtonsCityView = ActionsButtonsCityView(frame: CGRect(x: 0,
                                                                              y: 0,
                                                                              width: UIScreen.main.bounds.width,
                                                                              height: 60))
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    
    // MARK: - Public properties
    
    // Текущий город
    var currentCity: String = ""
    var interactor: CityBussinessLogic?
    var router: (NSObjectProtocol & CityRoutingLogic & CityDataPassing)?
    var viewModelWeather = CityViewModel.CurrentCity.ViewModel(
        city: "",
        weather: CurrentWeatherSevenDays(currentWeather: CurrentWeatherOfSevenDays(todayTemp: 0.0,
                                                                                   imageWeather: UIImage(),
                                                                                   description: "",
                                                                                   feelsLike: 0.0,
                                                                                   sunrise: 0,
                                                                                   sunset: 0),
                                         sevenDaysWeather: [WeatherSevenDays(dayOfWeek: 0,
                                                                             tempFrom: 0.0,
                                                                             tempTo: 0.0,
                                                                             image: UIImage(),
                                                                             description: "")]))
    
    var viewModelCity: CityViewModel.AllCountriesInTheWorld.ViewModel = CityViewModel.AllCountriesInTheWorld.ViewModel(
        titlesec: TitleSection(country: "11",
                               subTitle: "11",
                               latitude: 0.0,
                               longitude: 0.0,
                               available: true,
                               iconName: ""),
        model: [])
    
    // MARK: - Private Properties
    
    // Тайтл экрана
    private var titleName: String = ""
    
    // Модель всех достопримечательностей
    private var sightsArray = [SightsModel]()
    
    // Модель Билетов на экскурсии
    private var guidesArray: [GuideSightsModel] = [
        GuideSightsModel(image: UIImage(named: "hermitage2")!, name: "Эрмитаж", price: 1060, rating: 4.5, reviews: 79),
        GuideSightsModel(image: UIImage(named: "exhbgrandmaket")!, name: "Гранд Макет Россия", price: 6500, rating: 4.5, reviews: 1231),
        GuideSightsModel(image: UIImage(named: "exhbroof")!, name: "Экскурсия по крышам", price: 5305, rating: 0, reviews: 53),
        GuideSightsModel(image: UIImage(named: "exhbrusmuseum")!, name: "Государственный Русский музей", price: 928, rating: 4.1, reviews: 11),
        GuideSightsModel(image: UIImage(named: "exhblebed")!, name: "Лебединое озеро", price: 2341, rating: 4.2, reviews: 46)]
    
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
        presenter.cityController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUserDefault() {
        
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
        // кнопки
        tableView.register(ButtonsCollectionViewCell.self,
                           forCellReuseIdentifier: ButtonsCollectionViewCell.identifier)
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

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CityController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    // MARK: - заполнение каждой ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
            // картинки города
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryPhotosTableViewCell.identifier,
                                                           for: indexPath) as? CountryPhotosTableViewCell else { return UITableViewCell() }
            cell.configureCell(cityImages: viewModelCity.model?[0].images ?? [])
            return cell
            
            // описание
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryDescriptionTableViewCell.identifier,
                                                           for: indexPath) as? CountryDescriptionTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configureCell(titleName: "Описание города",
                               description: viewModelCity.model?[0].description ?? "Описание города")
            selectedDescriptionCell
            ? cell.moreButtons.setTitle(Constants.Cells.hideDescription, for: .normal)
            : cell.moreButtons.setTitle(Constants.Cells.readMore, for: .normal)
            return cell
            
            // Самое посещаемое
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier,
                                                           for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            let filteredModel = sightsArray.filter({ $0.categoryType == .interesting })
            cell.delegate = self
            cell.configureCell(model: filteredModel,
                               title: Constants.Cells.mostViewed,
                               size: CGSize(width: 230, height: 190))
            return cell
            
            // Обязательно к просмотру
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier,
                                                           for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            let filteredModel = sightsArray.filter({ $0.categoryType == .mustSee })
            cell.configureCell(model: filteredModel,
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCollectionViewCell.identifier,
                                                           for: indexPath) as? WeatherCollectionViewCell else { return UITableViewCell() }
            let weatherData = viewModelWeather.weather.currentWeather
            cell.configureCell(city: titleName,
                               curTemp: Int(weatherData.todayTemp),
                               curImage: weatherData.imageWeather,
                               description: weatherData.description,
                               feelLike: Int(weatherData.feelsLike),
                               sunrise: weatherData.sunrise,
                               sunset: weatherData.sunset)
            cell.delegate = self
            return cell
            
            // Выбор редакции
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier, for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            let filteredModel = sightsArray.filter({ $0.categoryType == .selection })
            cell.delegate = self
            cell.configureCell(model: filteredModel,
                               title: Constants.Cells.chooseOfRedaction,
                               size: CGSize(width: 230, height: 180))
            return cell
            
            // Интересные места
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier,
                                                           for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            let filteredModel = sightsArray.filter({ $0.categoryType == .mostViewed })
            cell.configureCell(model: filteredModel,
                               title: Constants.Cells.intrestingViews,
                               size: CGSize(width: 230, height: 180))
            return cell
            
        default: return UITableViewCell()
        }
        
    }
    // MARK: - высота каждой ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            
        case 0: return UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3) + 32
        case 1: return selectedDescriptionCell ? descriptionHeightCell : 200
        case 2: return 240
        case 3: return 240
        case 4: return 315
        case 5: return 256
        case 6: return 240
        case 7: return 240
        default: return 50
        }
    }
}

// MARK: - CountryDisplayLogic
extension CityController: CityDisplayLogic {
    
    // показ информации о текущем городе
    func displayCurrentCity(viewModelWeather: CityViewModel.CurrentCity.ViewModel, viewModelCityData: CityViewModel.AllCountriesInTheWorld.ViewModel, viewModelSightData: [SightsModel]) {
        title = viewModelWeather.city
        self.viewModelWeather = viewModelWeather
        self.viewModelCity = viewModelCityData
        self.sightsArray = viewModelSightData
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    
    // Обновить ячейку погоды после того как произошла загрузка с интернета данных
    func updateWeather(viewModel: CityViewModel.CurrentCity.ViewModel) {
        self.viewModelWeather.weather = viewModel.weather
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadRows(at: [IndexPath(row: 6, section: 0)], with: .automatic)
        }
    }
}

// MARK: - CountryDescriptionTableViewCellDelegate

extension CityController: CountryDescriptionTableViewCellDelegate {
    // определяем высоту для расширенной ячейки описание города
    func heightCell(height: CGFloat) {
        let standartHeightDataOfCell: CGFloat = 90
        descriptionHeightCell = height + standartHeightDataOfCell
    }
    
    // показываем больше текста в описании (расширяем таблицу)
    func showMoreText() {
        selectedDescriptionCell = !selectedDescriptionCell
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
    }
}

// MARK: - SightTableViewCellDelegate

extension CityController: SightTableViewCellDelegate {
    
    // открываем выбранную достопримечательность на карте
    func handleSelectedSight(_ name: String) {
        print("переход на карту и выбор достопримечательности: \(name)")
        userDefault.set(true, forKey: UserDefaults.showSelectedSight)
        userDefault.set(name, forKey: UserDefaults.showSelectedSightName)
        tabBarController?.selectedIndex = 0
    }
}

// MARK: - TicketCollectionViewCellDelegate

extension CityController: TicketCollectionViewCellDelegate {
    
    // открыть страницу всех билетов
    func lookAllTickets() {
        interactor?.openTicketSite()
    }
}

// MARK: - WeatherCollectionViewCellDelegate

extension CityController: WeatherCollectionViewCellDelegate {
    func showFullWeather() {
        router?.routeToFullWeatherVC()
    }
}

// MARK: - ActionsButtonsCityViewDelegate

extension CityController: ActionsButtonsCityViewDelegate {
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
