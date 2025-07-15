//
//  Array+Ext.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 12.07.2025.
//

import Foundation

extension Array {
    
    func get(_ index: Int) -> Element? {
        self.indices.contains(index) ? self[index] : nil
    }
}
