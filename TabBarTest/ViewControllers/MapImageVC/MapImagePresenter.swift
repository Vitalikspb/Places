//
//  MapImagePresenter.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 18.12.2021.
//

import Foundation
import UIKit

protocol MapImagePresentationLogic: AnyObject {
    func presentMapImage(response: MapImageModels.MapImageModel.Response)
}

final class MapImagePresenter: MapImagePresentationLogic {
    
    weak var mapImageController: MapImageController?
    
    func presentMapImage(response: MapImageModels.MapImageModel.Response) {
        let mainImage = UIImage(named: response.mapImage) ?? UIImage(systemName: "gear")!
        mapImageController?.displayMapImage(
            viewModel: MapImageModels.MapImageModel.ViewModel(nameOfMap: response.nameOfMap,
                                                              mapImage: mainImage))
        
    }
}
