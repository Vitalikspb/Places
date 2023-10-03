//
//  WorldInteractor.swift
//  TabBarTest
//
//

import UIKit



protocol WorldBussinessLogic: AnyObject {
    func showCity()
}

protocol WorldDataStore: AnyObject {
    var currentCity: String { get set }
    var rentsService: WorldViewModels.AllCountriesInTheWorld.ViewModel { get set }
}

class WorldInteractor: WorldBussinessLogic, WorldDataStore {
    
    var rentsService = WorldViewModels.AllCountriesInTheWorld.ViewModel(
        model: [
            WorldViewModels.WorldViewModel(
                titlesec: WorldViewModels.TitleSection(name: "Россия",
                                                       subName: "12 городов, 954 мест",
                                                       iconCountry: UIImage(named: "iconRussia")!,
                                                       available: true),
                items: [
                    WorldViewModels.ItemData(name: "Санкт-Петерубрг", sights: 1, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Москва", sights: 1, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Краснодар", sights: 1, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Сочи", sights: 1, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Уфа", sights: 1, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Пенза", sights: 1, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Норильск", sights: 1, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Южно-Сахалинск", sights: 1, imageCity: UIImage(named: "hub3")!, available: true)])
            ,
            WorldViewModels.WorldViewModel(
                titlesec: WorldViewModels.TitleSection(name: "США",
                                                       subName: "18 городов, 1373 мест",
                                                       iconCountry: UIImage(named: "iconRussia")!,
                                                       available: false),
                items: [
                    WorldViewModels.ItemData(name: "Чикаго", sights: 2, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Лос-Анджелес", sights: 2, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Хьюстон", sights: 2, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Финикс", sights: 2, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Филадельфия", sights: 2, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Сан-Антонио", sights: 2, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Сан-Диего", sights: 2, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Даллас", sights: 2, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Сан-Хосе", sights: 2, imageCity: UIImage(named: "hub3")!, available: false)])
            ,
            
            WorldViewModels.WorldViewModel(
                titlesec: WorldViewModels.TitleSection(name: "Тайланд",
                                                       subName: "5 городов, 500 мест",
                                                       iconCountry: UIImage(named: "iconRussia")!,
                                                       available: false),
                items: [
                    WorldViewModels.ItemData(name: "Бангкок", sights: 3, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Пхукет", sights: 3, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Ко тао", sights: 3, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Самуи", sights: 3, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Чонбури", sights: 3, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Хуахин", sights: 3, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Чумпхон", sights: 3, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Паттайя", sights: 3, imageCity: UIImage(named: "hub3")!, available: false)])
            ,
            
            WorldViewModels.WorldViewModel(
                titlesec: WorldViewModels.TitleSection(name: "Тайланд1",
                                                       subName: "5 городов, 500 мест",
                                                       iconCountry: UIImage(named: "iconRussia")!,
                                                       available: true),
                items: [
                    WorldViewModels.ItemData(name: "Бангкок", sights: 4, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Пхукет", sights: 4, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Ко тао", sights: 4, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Самуи", sights: 4, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Чонбури", sights: 4, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Хуахин", sights: 4, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Чумпхон", sights: 4, imageCity: UIImage(named: "hub3")!, available: true),
                    WorldViewModels.ItemData(name: "Паттайя", sights: 4, imageCity: UIImage(named: "hub3")!, available: true)])
            ,
            
            WorldViewModels.WorldViewModel(
                titlesec: WorldViewModels.TitleSection(name: "Тайланд2",
                                                       subName: "5 городов, 500 мест",
                                                       iconCountry: UIImage(named: "iconRussia")!,
                                                       available: false),
                items: [
                    WorldViewModels.ItemData(name: "Бангкок", sights: 5, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Пхукет", sights: 5, imageCity: UIImage(named: "hub3")!, available: false),
                    WorldViewModels.ItemData(name: "Ко тао", sights: 5, imageCity: UIImage(named: "hub3")!, available: false)])
        ])
    
    
    // выбранная страна куда будет осуществляться переход
    var currentCity: String = ""
    
    var presenter: WorldPresentationLogic?
    
    func showCity() {
        //        adasd
        //        Здесь создаем модель для текукщего города - заполняем модель все информацией -
        //        погодой,
        //        главными картинкам,
        //        описанием
        //        ссылками кнопок
        //        местами
        //        другими городами
        //        по этой модели будем заполнять экран а не как сейчас
        
        presenter?.presentAllMarkers(response: rentsService)
    }
    
}

