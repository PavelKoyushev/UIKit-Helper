//
//  SortType.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 19.06.2025.
//

import Foundation

enum SortType {
    
    case alphabetical
    case price
    
    var title: String {
        switch self {
        case .alphabetical: 
            return "Сортировать по алфавиту"
        case .price: 
            return "Сортировать по цене"
        }
    }
    
    var toggled: SortType {
        switch self {
        case .alphabetical:
            return .price
        case .price:
            return .alphabetical
        }
    }
}
