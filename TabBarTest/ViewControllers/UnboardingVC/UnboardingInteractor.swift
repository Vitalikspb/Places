//
//  UnboardingInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 07.12.2023.
//

import UIKit

protocol UnboardingBussinessLogic: AnyObject {
    func showUnboarding()
}

protocol UnboardingDataStore: AnyObject {
    var model: UnboardingModels.Unboarding.ViewModel { get set }
}



class UnboardingInteractor: UnboardingBussinessLogic, UnboardingDataStore {
    
    var presenter: UnboardingPresentationLogic?
    // 1 фильтрация
    // 2 информация и достопримечательности
    // 3 экран город
    // 4 избранное
    // 5 просмотр других стран
    
    var model = UnboardingModels.Unboarding.ViewModel(model: [
        UnboardingModels.OnboardingModel(id: 0,
                                         backgroundColor: "unboardingBG1",
                                         mainImage: UIImage(named: "hub3") ?? UIImage(),
                                         title: "Используйте фильтрацию для быстрого поиска",
                                         subTitle: "Фильтровать достопримечательности можно по категориям или самому в поиске",
                                         nextButtonTitle: "Далее"),
        UnboardingModels.OnboardingModel(id: 1,
                                         backgroundColor: "unboardingBG2",
                                         mainImage: UIImage(named: "hub3") ?? UIImage(),
                                         title: "Вся информация на ладони",
                                         subTitle: "Подробную информацию можно увидеть выбрав достопримечательность",
                                         nextButtonTitle: "Далее"),
        UnboardingModels.OnboardingModel(id: 2,
                                         backgroundColor: "unboardingBG3",
                                         mainImage: UIImage(named: "hub3") ?? UIImage(),
                                         title: "Вся информация о городе",
                                         subTitle: "Мы собрали всю самую необходимую и интересную информацию о городе с большим количством достопримечательностей",
                                         nextButtonTitle: "Далее"),
        UnboardingModels.OnboardingModel(id: 3,
                                         backgroundColor: "unboardingBG4",
                                         mainImage: UIImage(named: "hub3") ?? UIImage(),
                                         title: "Любимые места всегда под рукой",
                                         subTitle: "Если планируете поездку, добавляйте достопримечательности чтобы не потерять и обязательно туда сходить",
                                         nextButtonTitle: "Далее"),
        UnboardingModels.OnboardingModel(id: 4,
                                         backgroundColor: "unboardingBG5",
                                         mainImage: UIImage(named: "hub3") ?? UIImage(),
                                         title: "Больше стран больше интересных мест",
                                         subTitle: "Краская информацию про страны и города, с подробностями при выборе",
                                         nextButtonTitle: "Далее")])
        
    func showUnboarding() {
        presenter?.presentUnboarding(response: model)
    }
}
