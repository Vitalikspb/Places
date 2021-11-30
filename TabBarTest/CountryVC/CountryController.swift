//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit

protocol CountryDisplayLogic: AnyObject {
    func displayAllCities(viewModel: CountryViewModel.AllCitiesInCurrentCountry.ViewModel)
}

class CountryController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: CountryBussinessLogic?
    var router: (NSObjectProtocol & CountryRoutingLogic)?
    
    // MARK: - Private Properties
    
    private var titleName: String = ""
    var viewModel: [CountryViewModel.CityModel]!
    private let userDefault = UserDefaults.standard
    // выбранной ячейки для тапа по описанию и погоде, для увеличения высоты ячейки
    private var selectedDescriptionCell: Bool = false
    private struct DescriptionWeather {
        var temp: String
        var feelsLike: String
        var image: UIImage
        var description: String
        var sunrise: String
        var sunset: String
    }
    private var currentWeather: DescriptionWeather!
    
    // MARK: - UI Properties
    
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupClean()
        setupUI()
        viewModel =  [CountryViewModel.CityModel(name: "",
                                                 image: UIImage(named: "hub3")!)]
        tabBarController?.tabBar.items?[1].title = "Текущее"
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleName = userDefault.string(forKey: UserDefaults.currentCity) ?? ""
        title = titleName
        viewModel.removeAll()
        // в интеракторе создаем большую модель для заполнения всех ячеек таблицы, заголовка, погоды и всей остальой инфорамции
        //        interactor?.showCity()
    }
    
    
    // MARK: - Helper Functions
    
    // Настройка архитектуры Clean Swift
    private func setupClean() {
        let viewController = self
        let interactor = CountryInteractor()
        let presenter = CountryPresenter()
        let router = CountryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.CountryController = viewController
        router.viewController = viewController
    }
    
    private func setupUI() {
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
        // Обязательно к просмотру
        tableView.register(MustSeeTableViewCell.self,
                                forCellReuseIdentifier: MustSeeTableViewCell.identifier)
        // Билеты на экскурсии
        tableView.register(TicketCollectionViewCell.self,
                                forCellReuseIdentifier: TicketCollectionViewCell.identifier)
        // Погода
        tableView.register(WeatherCollectionViewCell.self,
                                forCellReuseIdentifier: WeatherCollectionViewCell.identifier)
        // Выбор редакции
        tableView.register(ChoiseRedactionTableViewCell.self,
                                    forCellReuseIdentifier: ChoiseRedactionTableViewCell.identifier)
        // Интересные места по близости
        tableView.register(NearbyPlacesTableViewCell.self,
                                    forCellReuseIdentifier: NearbyPlacesTableViewCell.identifier)
        // Музеи
        tableView.register(MuseumsTableViewCell.self,
                                forCellReuseIdentifier: MuseumsTableViewCell.identifier)
        // Парки
        tableView.register(ParksCollectionViewCell.self,
                                forCellReuseIdentifier: ParksCollectionViewCell.identifier)
        //        // ПЕРЕИСПОЛЬЗУЕМАЯ выбор редакции - лучшие места текущего города
        //        tableView.register(CountryCollectionViewCell.self,
        //                                forCellReuseIdentifier: CountryCollectionViewCell.identifier)
        //        // ПЕРЕИСПОЛЬЗУЕМАЯ выбор редакции - лучшие места текущего города
        //        tableView.register(CountryCollectionViewCell.self,
        //                                forCellReuseIdentifier: CountryCollectionViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        view.addSubview(tableView)
        
        tableView.anchor(top: view.topAnchor,
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

// MARK: - CountryDisplayLogic
extension CountryController: CountryDisplayLogic {
    func displayAllCities(viewModel: CountryViewModel.AllCitiesInCurrentCountry.ViewModel) {
        self.viewModel = viewModel.cities
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CountryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        
        // картинки города
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryPhotosTableViewCell.identifier, for: indexPath) as? CountryPhotosTableViewCell else { return UITableViewCell() }
            return cell
            
        // описание
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryDescriptionTableViewCell.identifier, for: indexPath) as? CountryDescriptionTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            selectedDescriptionCell ?
                cell.moreButtons.setTitle("Скрыть", for: .normal) :
                cell.moreButtons.setTitle("Читать далее", for: .normal)
            return cell
            
        // другие города
        case 10:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCitiesTableViewCell.identifier, for: indexPath) as? CountryCitiesTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
            
        // кнопки
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonsCollectionViewCell.identifier, for: indexPath) as? ButtonsCollectionViewCell else { return UITableViewCell() }
            return cell
            
        // Обязательно к просмотру
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MustSeeTableViewCell.identifier, for: indexPath) as? MustSeeTableViewCell else { return UITableViewCell() }
            return cell
            
        // Билеты на экскурсии
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TicketCollectionViewCell.identifier, for: indexPath) as? TicketCollectionViewCell else { return UITableViewCell() }
            return cell
            
        // Погода
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else { return UITableViewCell() }
            cell.configureCell(city: titleName, latitude: 59.9396340, longitude: 30.3104843)
            return cell
            
        // Выбор редакции
        case 7:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChoiseRedactionTableViewCell.identifier, for: indexPath) as? ChoiseRedactionTableViewCell else { return UITableViewCell() }
            return cell
            
        // Интересные места по близости
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NearbyPlacesTableViewCell.identifier, for: indexPath) as? NearbyPlacesTableViewCell else { return UITableViewCell() }
            return cell
            
        // Музеи
        case 8:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MuseumsTableViewCell.identifier, for: indexPath) as? MuseumsTableViewCell else { return UITableViewCell() }
            return cell
            
        // Парки
        case 9:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ParksCollectionViewCell.identifier, for: indexPath) as? ParksCollectionViewCell else { return UITableViewCell() }
            return cell
            
        default: return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        
        // ячейка с картинками текущего города
        case 0: return UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3) + 32
            
        // ячейка с описанием города
        case 1: return selectedDescriptionCell ? 380 : 200
            
        // ячейка с другими городами текущей страны где есть метки
        case 2: return 215
        
        // ячейка с кнопками
        case 3: return 150
            
        // Обязательно к просмотру
        case 4: return 180
            
        // Билеты на экскурсии
        case 5: return 230
            
        // Погода
        case 6: return 200
            
        // Выбор редакции
        case 7: return 215
        
        // Интересные места по близости
        case 8: return 180
            
        // Музеи
        case 9: return 180
        
        // Парки
        case 10: return 220
            
        default: return 50
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToCityVC()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
}

extension CountryController: CountryDescriptionTableViewCellDelegate {
    func showMoreText() {
        selectedDescriptionCell = !selectedDescriptionCell
        tableView.reloadData()
    }
}

extension CountryController: CountryCitiesTableViewCellDelegate {
    func showSelectedCityOnMap(_ lat: Double, _ lon: Double) {
            self.userDefault.set(true, forKey: UserDefaults.showSelectedCity)
            self.userDefault.set(lat, forKey: UserDefaults.showSelectedCityWithLatitude)
            self.userDefault.set(lon, forKey: UserDefaults.showSelectedCityWithLongitude)
            self.tabBarController?.selectedIndex = 0
    }
}





