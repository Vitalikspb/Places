//
//  IntrestingEventsInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.11.2021.
//

import UIKit

protocol IntrestingEventsBussinessLogic {
    func showIntrestingEvents()
}

protocol IntrestingEventsDataStore {
    var currentCity: String { get set }
    var image: [UIImage] { get set }
}

class IntrestingEventsInteractor: IntrestingEventsBussinessLogic, IntrestingEventsDataStore {
    
    var image: [UIImage] = []
    var currentCity: String = ""
    var presenter: IntrestingEventsPresentationLogic?
    
    func showIntrestingEvents() {
        // создаем модель из БД из избранного
        
        let interestingEvent = [IntrestingEventsModels.IntrestingEventsModel(
            image: [UIImage(named: "hub3")!,
                    UIImage(named: "hub3")!,
                    UIImage(named: "hub3")!
                   ],
            name: "Фестиваль масок",
            descriptions: "Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание ",
            date: "05.12.2021"),
                                IntrestingEventsModels.IntrestingEventsModel(
                                    image: [UIImage(named: "hub3")!,
                                            UIImage(named: "hub3")!,
                                            UIImage(named: "hub3")!
                                           ],
                                    name: "День народного единства",
                                    descriptions: "Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание ",
                                    date: "05.12.2021"),
                                IntrestingEventsModels.IntrestingEventsModel(
                                    image: [UIImage(named: "hub3")!],
                                    name: "Флаг страны",
                                    descriptions: "Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание ",
                                    date: "05.12.2021"),IntrestingEventsModels.IntrestingEventsModel(
                                        image: [UIImage(named: "hub3")!,
                                                UIImage(named: "hub3")!,
                                                UIImage(named: "hub3")!,
                                                UIImage(named: "hub3")!,
                                                UIImage(named: "hub3")!,
                                                UIImage(named: "hub3")!,
                                                UIImage(named: "hub3")!
                                               ],
                                        name: "Фестиваль масок",
                                        descriptions: "Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание ",
                                        date: "05.12.2021"),
                                IntrestingEventsModels.IntrestingEventsModel(
                                    image: [UIImage(named: "hub3")!,
                                            UIImage(named: "hub3")!,
                                            UIImage(named: "hub3")!
                                           ],
                                    name: "День народного единства",
                                    descriptions: "Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание ",
                                    date: "05.12.2021"),
                                IntrestingEventsModels.IntrestingEventsModel(
                                    image: [UIImage(named: "hub3")!,
                                            UIImage(named: "hub3")!,
                                            UIImage(named: "hub3")!
                                           ],
                                    name: "Флаг страны",
                                    descriptions: "Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание Интересное описание ",
                                    date: "05.12.2021")
        ]
        image = [UIImage(named: "hub3")!,
                 UIImage(named: "hub3")!,
                 UIImage(named: "hub3")!
                ]
        let viewModel = IntrestingEventsModels.IntrestingEvents.ViewModel(country: currentCity, events: interestingEvent)
        presenter?.presentIntrestingEvents(response: viewModel)
    }
}
