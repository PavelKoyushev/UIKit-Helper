//
//  AnimatedButton.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 29.11.2025.
//

import UIKit

final class AnimatedButton: UIView {
    
    private let buttonLayer = CALayer()
    private let titleLayer = CATextLayer()
    
    private let normalColor  = #colorLiteral(red: 0.9215686275, green: 0.2823529412, blue: 0.3882352941, alpha: 1).cgColor
    private let pressedColor = #colorLiteral(red: 0.9603635761, green: 0.3949118025, blue: 0.460875491, alpha: 1).cgColor
    private let titleFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    var onButtonTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonLayer.frame = bounds
        buttonLayer.cornerRadius = bounds.height / 2
        
        titleLayer.frame = CGRect(x: 0, y: (bounds.height - titleFont.lineHeight) / 2,
                                  width: bounds.width, height: titleFont.lineHeight)
    }
    
    func setTitle(_ text: String) {
        titleLayer.string = text
    }
}

private extension AnimatedButton {
    
    func configureUI() {
        buttonLayer.backgroundColor = normalColor
        
        if let cg = CGFont(titleFont.fontName as CFString) {
            titleLayer.font = cg
            titleLayer.fontSize = titleFont.pointSize
        }
        titleLayer.alignmentMode = .center
        titleLayer.foregroundColor = UIColor.white.cgColor
        titleLayer.contentsScale = UIScreen.main.scale
        
        layer.addSublayer(buttonLayer)
        buttonLayer.addSublayer(titleLayer)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        onButtonTap?()
    }
    
    func setPressed(_ pressed: Bool) {
        let startColor = buttonLayer.backgroundColor
        let startScale = buttonLayer.value(forKeyPath: "transform.scale") as? CGFloat ?? 1.0
        
        let endColor = pressed ? pressedColor : normalColor
        let endScale: CGFloat = pressed ? 0.96 : 1.0
        
        buttonLayer.backgroundColor = endColor
        buttonLayer.transform = CATransform3DMakeScale(endScale, endScale, endScale)
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = startColor
        colorAnimation.toValue = endColor
        colorAnimation.duration = 0.12
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = startScale
        scaleAnimation.toValue = endScale
        scaleAnimation.duration = 0.12
        
        buttonLayer.add(colorAnimation, forKey: "colorAnimation")
        buttonLayer.add(scaleAnimation, forKey: "scaleAnimation")
    }
}

extension AnimatedButton {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        setPressed(true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        setPressed(false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        setPressed(false)
    }
}
