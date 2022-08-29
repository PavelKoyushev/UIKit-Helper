//
//  MainTextView.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 29.08.2022.
//

import UIKit

final class MainTextView: UITextView {
    
    init(frame: CGRect) {
        super.init(frame: frame, textContainer: .none)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

private extension MainTextView {
    
    func configure() {
        
        textContainerInset = UIEdgeInsets(top: 5, left: 4, bottom: 4, right: 4)
        
        autocapitalizationType = .none
        autocorrectionType = .no
        spellCheckingType = .no
        
        layer.borderWidth = 2
        layer.cornerRadius = 10
        layer.borderColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        clipsToBounds = true
        
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        tintColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        
        textAlignment = .left
        
        font = .systemFont(ofSize: 16, weight: .regular)
    }
}
