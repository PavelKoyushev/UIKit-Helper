//
//  GoodsService.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 20.06.2025.
//

import Foundation

protocol GoodsServiceProtocol {
    func fetchGoods() -> [Goods]
}

final class GoodsService: GoodsServiceProtocol {
    
    private let fileProvider: FileDataProviderProtocol
    private let decoder: DecoderServiceProtocol
    private let mapper: ProductMapperProtocol
    private let filename: String
    
    init(fileProvider: FileDataProviderProtocol,
         decoder: DecoderServiceProtocol,
         mapper: ProductMapperProtocol,
         filename: String = "goods") {
        
        self.fileProvider = fileProvider
        self.decoder = decoder
        self.mapper = mapper
        self.filename = filename
    }
}

extension GoodsService {
    
    func fetchGoods() -> [Goods] {
        guard let data = fileProvider.loadData(from: filename, withExtension: "json"),
              let result = decoder.decode([GoodsJSON].self, from: data) else {
            
            return []
        }
        return mapper.map(from: result)
    }
}
