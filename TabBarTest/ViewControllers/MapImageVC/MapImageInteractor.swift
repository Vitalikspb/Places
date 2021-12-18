//
//  MapImageInteractor.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.12.2021.
//

import UIKit

protocol MapImageBussinessLogic {
    func showMapImage()
}

protocol MapImageDataStore {
    var stringURLOfMap: String { get set }
    var nameOfMap: String { get set }
}

class MapImageInteractor: MapImageBussinessLogic, MapImageDataStore {
    
    var nameOfMap: String = ""
    var stringURLOfMap: String = ""
    var presenter: MapImagePresentationLogic?
    
    func showMapImage() {
        // тут запрашиваем у базы всю инфу по текущему городу
        presenter?.presentMapImage(
            response: MapImageModels.MapImageModel.Response(nameOfMap: nameOfMap,
                                                            mapImage: stringURLOfMap))
    }
}
