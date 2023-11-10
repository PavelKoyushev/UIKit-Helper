//
//  OtherFlow.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 30.10.2023.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa

final class OtherFlow: Flow {
    
    private let activeStepper: ActiveStepper
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.navigationBar.tintColor = .white
        return viewController
    }()
    
    init(activeStepper: ActiveStepper) {
        
        self.activeStepper = activeStepper
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .other:
            return otherScreen()
        
        default:
            return .none
        }
    }
    
    private func otherScreen() -> FlowContributors {
        
        let viewController = MainViewController()
        
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: viewController,
                        withNextStepper: activeStepper)
        ])
    }
}

