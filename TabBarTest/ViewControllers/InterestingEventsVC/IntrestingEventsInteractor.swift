//
//  IntrestingEventsInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol IntrestingEventsBussinessLogic: AnyObject {
    func showIntrestingEvents()
}

protocol IntrestingEventsDataStore: AnyObject {
    var currentCity: String { get set }
    var name: String { get set }
    var image: [UIImage] { get set }
    var description: String { get set }
    var date: String { get set }
}

class IntrestingEventsInteractor: IntrestingEventsBussinessLogic, IntrestingEventsDataStore {
    
    var date: String = ""
    var currentCity: String = ""
    var image: [UIImage] = []
    var name: String = ""
    var description: String = ""
    var presenter: IntrestingEventsPresentationLogic?
    
    func showIntrestingEvents() {
        // создаем модель из БД из избранного
        
        let interestingEvent = [
            IntrestingEventsModels.IntrestingEventsModel(
                image: [UIImage(named: "eventmaski")!,
                        UIImage(named: "eventmaski1")!,
                        UIImage(named: "eventmaski2")!,
                        UIImage(named: "eventmaski3")!,
                        UIImage(named: "eventmaski4")!
                       ],
                name: "Фестиваль масок",
                descriptions: "1Интересное описание Интересное описание Иs dfsdf нтересное описание Интересное описание Интересное описание Интересное описание Интересно sdf sdfsd fsе описание Интеs dfsресное описание Интересное описание Интересное описание Интересное описание Интересноd sd fsdе описаниеs dfsdf Интересное описание Интересн asdfое описание Интересное описание Интересное описание Интересное описанf dsdf dsfие Интересное описание Интересное описание Интересное описание a sdИнтересное описание sdf Интересное описание Интересное описание Интересное 2описание Интересное описание Интересное описание Интересное описание  dsf sdf описание Интересное описание Интересное описание Интерес sdfsdfdfное описаниеa sd Интересное описание Интересное описание sdf sdfsd  Интересное описание Интas dfресное описание Интересное описание 3kj fhfИнтересное описание Интересное описание Интересное описание Инs dfsdfтересное описание Интересное описание Интересное описание Иsdf sdf dsf нтересное описание Интересное описание Интересное описание Интересное описание a sdasИнтересное  fsdf sdние Интересное описание Интересное описание Инs dfsdfтересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное a sdописание Интересное 4a sdasd описание Интересное описание Иsad fнтересное описание Интересное описание Интересное a sdописание Интересное описание Интересное описание Интересное описание Интересное описание Интd fsdf sdf dsfsd fsdf ересное описание Интерa sdf dfsfd adесное описание Интересное описание Интересное описание Интересное описание a sdИнтересное описание Интересное опиs dfsdfсание Интересное описание 5Интересное описание Интересное описание a sdИнтересное описание Интересное описание Интересное описаниеs dfsdf Интересное описание Интересное описаниеa sd Интересное a sdописsdfsd fsание Интересное описание asd as dИнтересное описание Интересное описание Интересное  asdописание Интересное описание 6Интересное описание Интересное описание Интересное описание Интересное описание Интеf sdfs dfресное описание Интересное описs dfs dfsd fание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание ",
                date: "05.12.2021"),
            
            IntrestingEventsModels.IntrestingEventsModel(
                image: [UIImage(named: "eventedins")!,
                        UIImage(named: "eventedins1")!,
                        UIImage(named: "eventedins2")!
                       ],
                name: "День народного единства",
                descriptions: "Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание ",
                date: "05.12.2021"),
            IntrestingEventsModels.IntrestingEventsModel(
                image: [UIImage(named: "eventflag")!,
                        UIImage(named: "eventflag1")!,
                        UIImage(named: "eventflag2")!],
                name: "Флаг страны",
                descriptions: "Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание ",
                date: "05.12.2021")
        ]
        let viewModel = IntrestingEventsModels.IntrestingEvents.ViewModel(
            country: currentCity, events: interestingEvent)
        presenter?.presentIntrestingEvents(response: viewModel)
    }
}

