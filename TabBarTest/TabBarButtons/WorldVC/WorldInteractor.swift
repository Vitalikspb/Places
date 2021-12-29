//
//  WorldInteractor.swift
//  TabBarTest
//
//

import UIKit



protocol WorldBussinessLogic {
    func showCity()
}

protocol WorldDataStore {
    var currentCity: String { get set }
    var rentsService: WorldViewModels.AllCountriesInTheWorld.ViewModel { get set }
}

class WorldInteractor: WorldBussinessLogic, WorldDataStore {
    
    var rentsService = WorldViewModels.AllCountriesInTheWorld.ViewModel(model: [
        WorldViewModels.WorldViewModel(titlesec: WorldViewModels.TitleSection(name: "Россия", subName: "12 городов, 954 мест"),items: [
            WorldViewModels.ItemData(name: "Санкт-Петерубрг", subName: "Более 454 мест", imageCity: UIImage(named: "spb")!),
            WorldViewModels.ItemData(name: "Москва", subName: "Более 234 мест", imageCity: UIImage(named: "moskva")!),
            WorldViewModels.ItemData(name: "Краснодар", subName: "Более 231 мест", imageCity: UIImage(named: "krasnodar")!),
            WorldViewModels.ItemData(name: "Сочи", subName: "Более 123 мест", imageCity: UIImage(named: "sochi")!),
            WorldViewModels.ItemData(name: "Уфа", subName: "Более 156 мест", imageCity: UIImage(named: "ufa")!),
            WorldViewModels.ItemData(name: "Пенза", subName: "Более 132 мест", imageCity: UIImage(named: "penza")!),
            WorldViewModels.ItemData(name: "Норильск", subName: "Более 95 мест", imageCity: UIImage(named: "norilsk")!),
            WorldViewModels.ItemData(name: "Южно-Сахалинск", subName: "Более 123 мест", imageCity: UIImage(named: "ujno-sahalinsk")!)]),
        WorldViewModels.WorldViewModel(titlesec: WorldViewModels.TitleSection(name: "Франция", subName: "17 городов, 1042 мест"),items: [
            WorldViewModels.ItemData(name: "Париж", subName: "Более 112 мест", imageCity: UIImage(named: "parij")!),
            WorldViewModels.ItemData(name: "Ажен", subName: "Более 123 мест", imageCity: UIImage(named: "ajen")!),
            WorldViewModels.ItemData(name: "Калаис", subName: "Более 134 мест", imageCity: UIImage(named: "kalais")!),
            WorldViewModels.ItemData(name: "Каен", subName: "Более 154 мест", imageCity: UIImage(named: "kaen")!),
            WorldViewModels.ItemData(name: "Шанелл", subName: "Более 164 мест", imageCity: UIImage(named: "shanel")!),
            WorldViewModels.ItemData(name: "Капентрасс", subName: "Более 131 мест", imageCity: UIImage(named: "kapentrace")!),
            WorldViewModels.ItemData(name: "Блойс", subName: "Более 141 мест", imageCity: UIImage(named: "bloise")!),
            WorldViewModels.ItemData(name: "Еус", subName: "Более 131 мест", imageCity: UIImage(named: "eus")!),
            WorldViewModels.ItemData(name: "Метз", subName: "Более 98 мест", imageCity: UIImage(named: "metz")!)]),
        WorldViewModels.WorldViewModel(titlesec: WorldViewModels.TitleSection(name: "США", subName: "18 городов, 1373 мест"),items: [
            WorldViewModels.ItemData(name: "Чикаго", subName: "Более 67 мест", imageCity: UIImage(named: "chicago")!),
            WorldViewModels.ItemData(name: "Лос-Анджелес", subName: "Более 87 мест", imageCity: UIImage(named: "losAngeles")!),
            WorldViewModels.ItemData(name: "Хьюстон", subName: "Более 56 мест", imageCity: UIImage(named: "houston")!),
            WorldViewModels.ItemData(name: "Финикс", subName: "Более 134 мест", imageCity: UIImage(named: "phoenix")!),
            WorldViewModels.ItemData(name: "Филадельфия", subName: "Более 123 мест", imageCity: UIImage(named: "filadelphia")!),
            WorldViewModels.ItemData(name: "Сан-Антонио", subName: "Более 152 мест", imageCity: UIImage(named: "sanAntonio")!),
            WorldViewModels.ItemData(name: "Сан-Диего", subName: "Более 123 мест", imageCity: UIImage(named: "sanDiego")!),
            WorldViewModels.ItemData(name: "Даллас", subName: "Более 90 мест", imageCity: UIImage(named: "dallas")!),
            WorldViewModels.ItemData(name: "Сан-Хосе", subName: "Более 87 мест", imageCity: UIImage(named: "sanHose")!)]),
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

