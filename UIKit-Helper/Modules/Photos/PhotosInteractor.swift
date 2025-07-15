//
//  PhotosInteractor.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 15.07.2025.
//

import Foundation

protocol PhotosInteractorProtocol {
    func fetchData()
}

final class PhotosInteractor: PhotosInteractorProtocol {
    
    var presenter: PhotosPresentationProtocol?
    
    deinit {
        print("\(Self.self) deinited")
    }
}

extension PhotosInteractor {
    
    func fetchData() {
        let model = PhotosScreenModel(trial: FreeTrialModel.mock,
                                      tags: TagModel.mock,
                                      pictures: PictureModel.mock)
        presenter?.presentModel(model)
    }
}
