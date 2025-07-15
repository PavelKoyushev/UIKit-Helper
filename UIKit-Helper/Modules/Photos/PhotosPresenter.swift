//
//  PhotosViewModel.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 15.07.2025.
//

import Foundation

protocol PhotosPresentationProtocol {
    func presentModel(_ model: PhotosScreenModel)
}

final class PhotosPresenter: PhotosPresentationProtocol {
    
    weak var viewController: PhotosViewOutputProtocol?
    
    deinit {
        print("\(Self.self) deinited")
    }
}

extension PhotosPresenter {
    
    func presentModel(_ model: PhotosScreenModel) {
        viewController?.displayModel(model)
    }
}
