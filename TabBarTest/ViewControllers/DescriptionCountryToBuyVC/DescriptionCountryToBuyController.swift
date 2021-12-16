//
//  DescriptionCountryToBuyController.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol DescriptionCountryToBuyDisplayLogic: AnyObject {
    func displayCurrentCountry(viewModel: String)
}

class DescriptionCountryToBuyController: UIViewController {

    
    // MARK: - UI Properties
    
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    
    // MARK: - Public Properties
    
    var interactor: DescriptionCountryToBuyBussinessLogic?
    var router: (NSObjectProtocol & DescriptionCountryToBuyRoutingLogic & DescriptionCountryToBuyDataPassing)?
    var viewModel: String = ""
    
    //MARK: - Private properties
    private let userDefault = UserDefaults.standard
    // выбранной ячейки для тапа по описанию, для увеличения высоты ячейки
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
    private var descriptionHeightCell: CGFloat = 0
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
        // в интеракторе создаем большую модель для заполнения всех ячеек таблицы, заголовка, погоды и всей остальой инфорамции
        //        interactor?.showCity()
    }

    // MARK: - Helper Functions
    
    // Настройка архитектуры Clean Swift
    private func setupClean() {
        let viewController = self
        let interactor = DescriptionCountryToBuyInteractor()
        let presenter = DescriptionCountryToBuyPresenter()
        let router = DescriptionCountryToBuyRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.descriptionCountryToBuyController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUserDefault() {
        
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
        // Переиспользуемая для всех интересных мест
        tableView.register(SightTableViewCell.self,
                           forCellReuseIdentifier: SightTableViewCell.identifier)
        // Билеты на экскурсии
        tableView.register(TicketCollectionViewCell.self,
                           forCellReuseIdentifier: TicketCollectionViewCell.identifier)
        // Погода
        tableView.register(WeatherCollectionViewCell.self,
                           forCellReuseIdentifier: WeatherCollectionViewCell.identifier)

        // +1
        //        tableView.register(MuseumsTableViewCell.self,
        //                                forCellReuseIdentifier: MuseumsTableViewCell.identifier)

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

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension DescriptionCountryToBuyController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    // MARK: - заполнение каждой ячейки
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
            cell.configureCell(titleName: "Описание страны",
                               description: "lasdfalsdfh; asflsadh flasdflhdl hlshd flsdhf ls flsldf jlsfs a;lf sldf ls;dlfjh lsajfdlsdflj ljsdfl sdflkjs;d lj sld l;skadjh ljhl;sdjhflsa sdlakhjf l;jsdl jlsdj lfjsd;l ljs;f jl;saj ;lskjdf lsjad kj ksadl jl;sj ;sdj fjsdl;jsjdfjl;sa ;s;ldkfl ;js;fkjsa lasdfalsdfh; asflsadh flasdflhdl hlshd flsdhf ls flsldf jlsfs a;lf sldf ls;dlfjh lsajfdlsdflj ljsdfl sdflkjs;d lj sld l;skadjh ljhl;sdjhflsa sdlakhjf l;jsdl jlsdj lfjsd;l ljs;f jl;saj ;lskjdf lsjad kj ksadl jl;sj ;sdj fjsdl;jsjdfjl;sa ;s;ldkfl ;js;fkjsa lasdfalsdfh; asflsadh flasdflhdl hlshd flsdhf ls flsldf jlsfs a;lf sldf ls;dlfjh lsajfdlsdflj ljsdfl sdflkjs;d lj sld l;skadjh ljhl;sdjhflsa sdlakhjf l;jsdl jlsdj lfjsd;l ljs;f jl;saj ;lskjdf lsjad kj ksadl jl;sj ;sdj fjsdl;jsjdfjl;sa ;s;ldkfl ;js;fkjsa lasdfalsdfh; asflsadh flasdflhdl hlshd flsdhf ls flsldf jlsfs a;lf sldf ls;dlfjh lsajfdlsdflj ljsdfl sdflkjs;d lj sld l;skadjh ljhl;sdjhflsa sdlakhjf l;jsdl jlsdj lfjsd;l ljs;f jl;saj ;lskjdf lsjad kj ksadl jl;sj ;sdj fjsdl;jsjdfjl;sa ;s;ldkfl ;js;fkjsa lasdfalsdfh; asflsadh flasdflhdl hlshd flsdhf ls flsldf jlsfs a;lf sldf ls;dlfjh lsajfdlsdflj ljsdfl sdflkjs;d lj sld l;skadjh ljhl;sdjhflsa sdlakhjf l;jsdl jlsdj lfjsd;l ljs;f jl;saj ;lskjdf lsjad kj ksadl jl;sj ;sdj fjsdl;jsjdfjl;sa ;s;ldkfl ;js;fkjsa")
            selectedDescriptionCell
                ? cell.moreButtons.setTitle(Constants.Cells.hideDescription, for: .normal)
                : cell.moreButtons.setTitle(Constants.Cells.readMore, for: .normal)
            return cell
            
            // Интересные места по близости
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier, for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.titleCell = Constants.Cells.sightNearMe
            cell.sizeCell = CGSize(width: 230, height: 170)
            return cell
            
            // кнопки
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonsCollectionViewCell.identifier, for: indexPath) as? ButtonsCollectionViewCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
            
            // Обязательно к просмотру
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier, for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.titleCell = Constants.Cells.mustSeeSights
            cell.sizeCell = CGSize(width: 200, height: 140)
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier, for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.titleCell = Constants.Cells.chooseOfRedaction
            cell.sizeCell = CGSize(width: 230, height: 170)
            return cell
            
            // Музеи
        case 8:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier, for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.titleCell = Constants.Cells.museums
            cell.sizeCell = CGSize(width: 200, height: 140)
            return cell
            
            // Парки
        case 9:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SightTableViewCell.identifier, for: indexPath) as? SightTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.titleCell = Constants.Cells.parks
            cell.sizeCell = CGSize(width: 200, height: 140)
            return cell
            
            // другие города
            
        default: return UITableViewCell()
        }
        
    }
    // MARK: - высота каждой ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            
            // ячейка с картинками текущего города
        case 0: return UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3) + 32
            
            // ячейка с описанием города
        case 1: return selectedDescriptionCell ? descriptionHeightCell : 180
            
            // ячейка с другими городами текущей страны где есть метки
            // Выбор редакции
        case 2,7: return 215
            
            // ячейка с кнопками
        case 3: return 150
            
            // Билеты на экскурсии
        case 5: return 230
            
            // Погода
        case 6: return 200
            
            // Обязательно к просмотру
            // Интересные места по близости
            // Музеи
        case 4,8,9: return 180
            
        default: return 50
        }
    }
    // MARK: - белое заполнение пустой части таблицы
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
}

// MARK: - CountryDisplayLogic
extension DescriptionCountryToBuyController: DescriptionCountryToBuyDisplayLogic {
    func displayCurrentCountry(viewModel: String) {
        title = viewModel
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    // показ информации о текущем городе
    // отображение обновленной таблицы после заполнения в интеракторе данными модели
    // пока что не работает т.к нету модели

}

// MARK: - CountryDescriptionTableViewCellDelegate

extension DescriptionCountryToBuyController: CountryDescriptionTableViewCellDelegate {
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

extension DescriptionCountryToBuyController: SightTableViewCellDelegate {
    // открываем выбранную достопримечательность на карте
    func handleSelectedSight(_ name: String) {
        userDefault.set(true, forKey: UserDefaults.showSelectedSight)
        userDefault.set(name, forKey: UserDefaults.showSelectedSightName)
        tabBarController?.selectedIndex = 0
    }
}

// MARK: - ButtonsCollectionViewCellDelegate

extension DescriptionCountryToBuyController: ButtonsCollectionViewCellDelegate {
    // открываем экран списка любимых/избранных достопримечательностей
    func favouritesHandler() {
    }
    
    func eventsHandler() {
        
    }
    
    func ticketHandler() {
        
    }
    
    func faqHandler() {
        
    }
    
    func rentAutoHandler() {
        
    }
    
    func chatHandler() {
    }
}
