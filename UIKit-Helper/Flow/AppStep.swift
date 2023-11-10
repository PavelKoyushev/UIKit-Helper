//
//  AppStep.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 16.10.2023.
//

import RxFlow

enum AppStep: Step {
    
    case dashboard
    
    case home
    case store
    case other
    
    case dinersList
    case diner(model: Diner)
}
