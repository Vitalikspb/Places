//
//  WorldWorker.swift
//  TabBarTest
//
//  Created by ViceCode on 14.12.2021.
//

import Foundation

class WorldWorker {
    
    // Запрос на интересные события
    static func updateCountry(model: ModelForRequest, completion: @escaping()->()) {
//        NetworkHelper.shared.makeRequest(type: .cityAll, model: model) {
            completion()
//        }
    }
    
    static func addTestCountries(_ mainModel: inout [WorldViewModels.AllCountriesInTheWorld.ViewModel]) {
        let titleModelTai = TitleSection(country: "Тайланд",
                                                      subTitle: "9 городов, 141 места",
                                                      latitude: 13.771374,
                                                      longitude: 100.513785,
                                                         available: false,
                                                         iconName: "iconTailand")
        let citiesModelTai = [SightDescription(id: 0,
                                            name: "Пхукет",
                                            description: "Описание города",
                                            price: 0,
                                            sight_count: 18,
                                            latitude: 7.877035,
                                            longitude: 98.396866,
                                               images: ["1651018460_25-vsegda-pomnim-com-p-pkhuket-more-foto-31.jpg"]),
                           SightDescription(id: 1,
                                            name: "Паттайя",
                                            description: "Описание города",
                                            price: 0,
                                            sight_count: 17,
                                            latitude: 12.922846,
                                            longitude: 100.882738,
                                            images: ["1667584401_30-sportishka-com-p-dostoprimechatelnosti-pattaiya-krasivo-32.jpg"]),
                           SightDescription(id: 2,
                                            name: "Самуи",
                                            description: "Описание города",
                                            price: 0,
                                            sight_count: 11,
                                            latitude: 9.502883,
                                            longitude: 99.992786,
                                            images: ["samuikomu-drugie-kotao-2048x1363.jpg"]),
                           SightDescription(id: 3,
                                            name: "Као Лак",
                                            description: "Описание города",
                                            price: 0,
                                            sight_count: 19,
                                            latitude: 8.691884,
                                            longitude: 98.257223,
                                            images: ["7c786f286a01e789200bb2f5a8d43c24"]),
                           SightDescription(id: 4,
                                            name: "Хуахин",
                                            description: "Описание города",
                                            price: 0,
                                            sight_count: 11,
                                            latitude: 12.574982,
                                            longitude: 99.949370,
                                            images: ["6762659f2ce2907a0212281940b90d8f-2.jpg"]),
                           SightDescription(id: 5,
                                            name: "Краби",
                                            description: "Описание города",
                                            price: 0,
                                            sight_count: 17,
                                            latitude: 8.070850,
                                            longitude: 98.916460,
                                            images: ["6b01da088df9f08fb105a88ec3d9f4ad.jpg"]),
                           SightDescription(id: 6,
                                            name: "Ко Тао",
                                            description: "Описание города",
                                            price: 0,
                                            sight_count: 20,
                                            latitude: 10.093892,
                                            longitude: 99.834610,
                                            images: ["1667558490_19-sportishka-com-p-ostrov-ko-tao-v-tailande-pinterest-20.jpg"]),
                           SightDescription(id: 7,
                                            name: "Ко Ланта",
                                            description: "Описание города",
                                            price: 0,
                                            sight_count: 13,
                                            latitude: 7.558285,
                                            longitude: 99.064611,
                                            images: ["diving_v_kolante_0.jpg"]),
                           SightDescription(id: 8,
                                            name: "Панган",
                                            description: "Описание города",
                                            price: 0,
                                            sight_count: 15,
                                            latitude: 9.743697,
                                            longitude: 100.025619,
                                            images: ["pangan"])]
        
        mainModel.append(WorldViewModels.AllCountriesInTheWorld.ViewModel(titlesec: titleModelTai,
                                                                           model: citiesModelTai))
    }
}
