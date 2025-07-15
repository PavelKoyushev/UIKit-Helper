//
//  TagModel.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 15.07.2025.
//

import Foundation

struct TagModel {
    
    let id: String
    let title: String
}

extension TagModel {
    
    static var mock: [Self] {
        [
            .init(id: "x1", title: "#Осень"),
            .init(id: "x2", title: "#Портрет"),
            .init(id: "x3", title: "#Insta-стиль"),
            .init(id: "x4", title: "#Люди"),
            .init(id: "x5", title: "#Природа"),
            .init(id: "x6", title: "#Котята"),
            .init(id: "x7", title: "#Лето"),
            .init(id: "x8", title: "#Пейзаж"),
        ]
    }
}
