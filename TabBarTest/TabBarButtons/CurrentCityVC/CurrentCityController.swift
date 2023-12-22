//
//  CityController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit
import CoreLocation

protocol CurrentCityDisplayLogic: AnyObject {
    func displayCurrentCity(viewModelWeather: CurrentCityViewModel.CurrentCity.ViewModel, viewModelCityData: CurrentCityViewModel.AllCountriesInTheWorld.ViewModel, viewModelSightData: [Sight], otherCityData: [SightDescriptionResponce])
    func updateWeather(viewModel: CurrentCityViewModel.CurrentCity.ViewModel)
    func showSelectCity()
}

class CurrentCityController: UIViewController {
    
    
    // MARK: - UI Properties
    
    private let actionsButtonsCityView = ActionsButtonsCityView(frame: CGRect(x: 0,
                                                                              y: 0,
                                                                              width: UIScreen.main.bounds.width,
                                                                              height: 60))
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    private let whiteView: UIView = {
       let view = UIView()
        view.backgroundColor = .setCustomColor(color: .mainView)
        return view
    }()
    
    
    // MARK: - Public properties
    
    // Текущий город
    var currentCity: String = ""
    var interactor: CurrentCityBussinessLogic?
    var router: (NSObjectProtocol & CurrentCityRoutingLogic & CurrentCityDataPassing)?
    var viewModelWeather = CurrentCityViewModel.CurrentCity.ViewModel(
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
    
    var viewModelCity: CurrentCityViewModel.AllCountriesInTheWorld.ViewModel = CurrentCityViewModel.AllCountriesInTheWorld.ViewModel(
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
    private var sightsArray = [Sight]()
    private var sightsMostViewsArray = [Sight]()
    private var sightsMustSeeArray = [Sight]()
    private var sightsChooseRedactionArray = [Sight]()
    private var sightsInterestingArray = [Sight]()
    private var cityArray = [SightDescriptionResponce]()
    
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
    // возможные города с достопримечательностями
    private let cities = ["Санкт-Петербург", "Москва", "Екатеринбург", "Казань", "Новосибирск", "Нижний новгород"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleName = userDefault.string(forKey: UserDefaults.currentCity) ?? ""
        title = titleName
        currentCity = titleName

        if cities.contains(titleName) {
            interactor?.showCity(named: currentCity)
            router?.dataStore?.currentCity = currentCity
        } else {
            whiteView.isHidden = false
            interactor?.showSelectCity()
        }
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
        let interactor = CurrentCityInteractor()
        let presenter = CurrentCityPresenter()
        let router = CurrentCityRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.сurrentCityController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        let themeName = UserDefaults.standard.string(forKey: UserDefaults.themeAppSelected) ?? "Системная"
        updateSelectedTheme(name: themeName)
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .setCustomColor(color: .mainView)
        
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
        
        // другие города
        tableView.register(CountryCitiesTableViewCell.self,
                           forCellReuseIdentifier: CountryCitiesTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        view.addSubviews(actionsButtonsCityView, tableView, whiteView)
        
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
        whiteView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0, height: 0)
    }
    
    private func updateSelectedTheme(name: String) {
        guard #available(iOS 13.0, *) else { return }
        switch name {
        case "Светлая":
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light }
            
        case "Темная":
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark }
            
        default:
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .unspecified }
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CurrentCityController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.contains(titleName) ? 9 : 0
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
            cell.delegate = self
            cell.configureCell(model: sightsInterestingArray,
                               title: Constants.Cells.mostViewed,
                               size: CGSize(width: 230, height: 190))
            return cell
            
            // Обязательно к просмотру
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier,
                                                           for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configureCell(model: sightsMustSeeArray,
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
            cell.delegate = self
            cell.configureCell(model: sightsChooseRedactionArray,
                               title: Constants.Cells.chooseOfRedaction,
                               size: CGSize(width: 230, height: 180))
            return cell
            
            // Интересные места
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier,
                                                           for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configureCell(model: sightsMostViewsArray,
                               title: Constants.Cells.intrestingViews,
                               size: CGSize(width: 230, height: 180))
            return cell
            
            // другие города
        case 8:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCitiesTableViewCell.identifier,
                                                           for: indexPath) as? CountryCitiesTableViewCell else { return UITableViewCell() }
            cell.configCell(model: cityArray)
            cell.delegate = self
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
        case 8: return 320
        default: return 50
        }
    }
}

// MARK: - CountryDisplayLogic
extension CurrentCityController: CurrentCityDisplayLogic {
    
    func showSelectCity() {
        var cityName = "Город"
        if let title = title {
            cityName = title
        }
        let alertView = UIAlertController(title: "\(cityName) еще не добавлен в приложение!",
                                          message: "Выберите город из списка ниже",
                                          preferredStyle: .actionSheet)
        
        cities.forEach { city in
            let action = UIAlertAction(title: city, style: .default, handler: { [weak self] (alert: UIAlertAction!) -> Void in
                guard let self = self else { return }
                title = city
                self.titleName = city
                self.currentCity = city
                self.interactor?.showCity(named: city)
                self.router?.dataStore?.currentCity = city
                UserDefaults.standard.set(city, forKey: UserDefaults.currentCity)
            })
            alertView.addAction(action)
        }
        DispatchQueue.main.async {
        self.present(alertView, animated: true, completion: nil)
        }
    }
    
    
    // показ информации о текущем городе
    func displayCurrentCity(viewModelWeather: CurrentCityViewModel.CurrentCity.ViewModel, viewModelCityData: CurrentCityViewModel.AllCountriesInTheWorld.ViewModel, viewModelSightData: [Sight], otherCityData: [SightDescriptionResponce]) {
        self.viewModelWeather = viewModelWeather
        self.viewModelCity = viewModelCityData
        self.sightsArray = viewModelSightData
        self.cityArray = otherCityData
        
        sightsMostViewsArray = sightsArray.filter({ $0.category == .mostViewed })
        sightsMustSeeArray = sightsArray.filter({ $0.category == .mustSee })
        sightsChooseRedactionArray = sightsArray.filter({ $0.category == .selection })
        sightsInterestingArray = sightsArray.filter({ $0.category == .interesting })
        whiteView.isHidden = true
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    
    // Обновить ячейку погоды после того как произошла загрузка с интернета данных
    func updateWeather(viewModel: CurrentCityViewModel.CurrentCity.ViewModel) {
        self.viewModelWeather.weather = viewModel.weather
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadRows(at: [IndexPath(row: 6, section: 0)], with: .automatic)
        }
    }
}

// MARK: - CountryCitiesTableViewCellDelegate

extension CurrentCityController: CountryCitiesTableViewCellDelegate {
    // Открываем другой город из текущего
    func showSelectedCityDescription(_ name: String) {
        currentCity = name
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

// MARK: - CountryDescriptionTableViewCellDelegate

extension CurrentCityController: CountryDescriptionTableViewCellDelegate {
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

extension CurrentCityController: SightTableViewCellDelegate {
    
    // Было нажатие на избранное
    func favoritesTapped(name: String) {
        interactor?.updateFavorites(withName: name)
    }
    
    // открываем выбранную достопримечательность на карте
    func handleSelectedSight(_ name: String) {
        userDefault.set(true, forKey: UserDefaults.showSelectedSight)
        userDefault.set(name, forKey: UserDefaults.showSelectedSightName)
        tabBarController?.selectedIndex = 0
    }
}

// MARK: - TicketCollectionViewCellDelegate

extension CurrentCityController: TicketCollectionViewCellDelegate {
    
    // открыть страницу всех билетов
    func lookAllTickets() {
        interactor?.openTicketSite()
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
    
    // Открытие избранного
    func favouriteButtonTapped() {
        router?.routeToFavouritesVC()
    }
    
    // Открытие интересных событий
    func interestingButtonTapped() {
        router?.routeToInterestingEventsVC()
    }
    
    // Открытие вопросы и ответы
    func faqButtonTapped() {
        router?.routeToFAQVC()
    }
    
}

