//
//  PromoTourModel.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 22.02.2024.
//

import Foundation

protocol PromoCityCellProtocol {
    
    var city: String { get }
    var country: String { get }
    var imageName: String { get }
}

struct PromoTourModel: PromoCityCellProtocol {
    
    let city: String
    let country: String
    let imageName: String
    
    let description: String
}

extension PromoTourModel {
    
    static var mockArray: [Self] {
        [PromoTourModel(city: "Moscow",
                        country: "Russia",
                        imageName: "moscow",
                        description: "Great City 1"),
         PromoTourModel(city: "Minsk",
                        country: "Belarus",
                        imageName: "minsk",
                        description: "Great City 2"),
         PromoTourModel(city: "Kazan",
                        country: "Russia",
                        imageName: "kazan",
                        description: "Great City 3"),
         PromoTourModel(city: "Saint Petersburg",
                        country: "Russia",
                        imageName: "piter",
                        description: "Great City 4"),
         PromoTourModel(city: "Astana",
                        country: "Kazakhstan",
                        imageName: "astana",
                        description: "Great City 5")]
    }
}
