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
                titlesec: WorldViewModels.TitleSection(name: "Германия",
                                                       subName: "6 городов, 66 мест",
                                                       iconCountry: UIImage(named: "iconRussia")!,
                                                       available: true),
                items: [
                    WorldViewModels.ItemData(name: "Берлин", sights: 11, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Гамбург", sights: 22, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Гетенген", sights: 33, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Франкфурт", sights: 44, imageCity: UIImage(named: "hub3")!)])
            ,
            
            WorldViewModels.WorldViewModel(
                titlesec: WorldViewModels.TitleSection(name: "Россия",
                                                       subName: "12 городов, 954 мест",
                                                       iconCountry: UIImage(named: "iconRussia")!,
                                                       available: false),
                items: [
                    WorldViewModels.ItemData(name: "Санкт-Петерубрг", sights: 44, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Москва", sights: 13, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Краснодар", sights: 21, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Сочи", sights: 76, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Уфа", sights: 22, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Пенза", sights: 32, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Норильск", sights: 15, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Южно-Сахалинск", sights: 22, imageCity: UIImage(named: "hub3")!)])
            ,
            WorldViewModels.WorldViewModel(
                titlesec: WorldViewModels.TitleSection(name: "США",
                                                       subName: "18 городов, 1373 мест",
                                                       iconCountry: UIImage(named: "iconRussia")!,
                                                       available: false),
                items: [
                    WorldViewModels.ItemData(name: "Чикаго", sights: 67, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Лос-Анджелес", sights: 45, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Хьюстон", sights: 55, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Финикс", sights: 33, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Филадельфия", sights: 34, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Сан-Антонио", sights: 67, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Сан-Диего", sights: 67, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Даллас", sights: 12, imageCity: UIImage(named: "hub3")!),
                    WorldViewModels.ItemData(name: "Сан-Хосе", sights: 23, imageCity: UIImage(named: "hub3")!)])
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

