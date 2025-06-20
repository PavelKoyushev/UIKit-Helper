//
//  GoodsMapper.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 20.06.2025.
//

import Foundation

protocol ProductMapperProtocol {
    func map(from model: [GoodsJSON]) -> [Goods]
}

struct GoodsMapper: ProductMapperProtocol {
    
    func map(from model: [GoodsJSON]) -> [Goods] {
        model.map {
            Goods(name: $0.name,
                  price: $0.price,
                  description: $0.description)
        }
    }
}
