//
//  GoodsJSON.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 19.06.2025.
//

import Foundation

struct GoodsJSON: Decodable, Identifiable {
    let id: String
    let name: String
    let description: String
    let price: Double
}
