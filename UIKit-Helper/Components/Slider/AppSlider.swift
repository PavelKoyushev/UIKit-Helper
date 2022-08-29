//
//  AppSlider.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 29.08.2022.
//

import UIKit

final class AppSlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

private extension AppSlider {
    
    func configure() {
        
        maximumValue = 100
        minimumValue = 0
        
        setThumbImage(UIImage(systemName: "circlebadge.fill"), for: .normal)
        maximumValueImage = UIImage(systemName: "plus")
        minimumValueImage = UIImage(systemName: "minus")
    }
}
