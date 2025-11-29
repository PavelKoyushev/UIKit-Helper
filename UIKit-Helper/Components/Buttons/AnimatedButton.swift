//
//  MainButton.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 29.11.2025.
//

import UIKit

final class AnimatedButton: UIView {
    
    private let buttonLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        buttonLayer.frame = bounds
        buttonLayer.cornerRadius = 8
        buttonLayer.backgroundColor = UIColor.blue.cgColor
        layer.addSublayer(buttonLayer)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        // Анимация нажатия
        animateTap()
    }
    
    private func animateTap() {
        // Анимация масштаба
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.toValue = 0.95
        scaleAnim.duration = 0.1
        scaleAnim.autoreverses = true
        
        // Анимация цвета
        let colorAnim = CABasicAnimation(keyPath: "backgroundColor")
        colorAnim.toValue = UIColor.systemBlue.cgColor
        colorAnim.duration = 0.2
        
        // Анимация тени
        let shadowAnim = CABasicAnimation(keyPath: "shadowOpacity")
        shadowAnim.toValue = 0.3
        shadowAnim.duration = 0.2
        shadowAnim.autoreverses = true
        
        buttonLayer.add(scaleAnim, forKey: "scaleAnimation")
        buttonLayer.add(colorAnim, forKey: "colorAnimation")
        buttonLayer.add(shadowAnim, forKey: "shadowAnimation")
    }
}
