//
//  TitleButtonCellModel.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 22.02.2024.
//

import Foundation

protocol TitleButtonCellProtocol {
    
    var title: String { get }
    var step: AppStep { get }
    var isHiddenButton: Bool { get }
}

struct TitleButtonCellModel: TitleButtonCellProtocol {
    
    let title: String
    let step: AppStep
    var isHiddenButton: Bool = false
}
