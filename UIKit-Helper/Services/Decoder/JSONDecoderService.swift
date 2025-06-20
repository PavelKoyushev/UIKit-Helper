//
//  JSONDecoderService.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 20.06.2025.
//

import Foundation

protocol DecoderServiceProtocol {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T?
}

struct JSONDecoderService: DecoderServiceProtocol {
    
    private let decoder = JSONDecoder()

    func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        try? decoder.decode(T.self, from: data)
    }
}
