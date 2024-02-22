//
//  BestGuide.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 22.02.2024.
//

import Foundation

protocol BestGuideProtocol {
    
    var name: String { get }
    var photo: String { get }
}

struct BestGuide: BestGuideProtocol {
    
    let name: String
    let photo: String
    let info: String
}

extension BestGuide {
    
    static var mockArray: [Self] {
        [BestGuide(name: "Mary J.",
                   photo: "mary",
                   info: ""),
         BestGuide(name: "Dan S.",
                   photo: "dan",
                   info: ""),
         BestGuide(name: "Ian R.",
                   photo: "ian",
                   info: ""),
         BestGuide(name: "Sabina A.",
                   photo: "sabina",
                   info: "1"),
         BestGuide(name: "Emily C.",
                   photo: "emily",
                   info: "2"),
         BestGuide(name: "Antony M.",
                   photo: "antony",
                   info: "3")]
    }
}
