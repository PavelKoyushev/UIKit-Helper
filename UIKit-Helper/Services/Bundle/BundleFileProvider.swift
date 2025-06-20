//
//  BundleFileProvider.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 20.06.2025.
//

import Foundation

protocol FileDataProviderProtocol {
    func loadData(from filename: String, withExtension: String) -> Data?
}

struct BundleFileProvider: FileDataProviderProtocol {
    
    func loadData(from filename: String,
                  withExtension: String) -> Data? {
        
        guard let url = Bundle.main.url(forResource: filename,
                                        withExtension: withExtension) else {
            
            print("Файл \(filename).\(withExtension) не найден")
            return nil
        }
        return try? Data(contentsOf: url)
    }
}
