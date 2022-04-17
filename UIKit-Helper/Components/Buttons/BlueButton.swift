//
//  BlueButton.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 17.04.2022.
//

import UIKit

class BlueButton: UIButton {

    private let cornerRadius: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

}

private extension BlueButton {
    
    func configure() {
        backgroundColor = .systemCyan
        setTitleColor(.white, for: .normal)
        
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        layer.cornerRadius = cornerRadius
    }
}
