//
//  PictureModel.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 15.07.2025.
//

import Foundation

struct PictureModel {
    
    let id: String
    let name: String
}

extension PictureModel {
    
    static var mock: [Self] {
        [
            .init(id: "x1", name: "1"),
            .init(id: "x2", name: "2"),
            .init(id: "x3", name: "3"),
            .init(id: "x4", name: "4"),
            .init(id: "x5", name: "5"),
            .init(id: "x6", name: "6"),
            .init(id: "x7", name: "7"),
            .init(id: "x8", name: "8"),
        ]
    }
}
