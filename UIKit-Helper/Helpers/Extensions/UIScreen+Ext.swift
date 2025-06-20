//
//  UIScreen+Ext.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 19.06.2025.
//

import UIKit.UIScreen

extension UIScreen {
    static var bottomSafeArea: CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        return (keyWindow?.safeAreaInsets.bottom) ?? 0
    }
}
