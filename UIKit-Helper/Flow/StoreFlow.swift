//
//  StoreFlow.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 27.10.2023.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa

final class StoreFlow: Flow {
    
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
        case .store:
            return storeScreen()
        
        default:
            return .none
        }
    }
    
    private func storeScreen() -> FlowContributors {
        
        let viewController = StoreViewController()
        let viewModel = StoreViewModel()
        
        viewController.inject(viewModel: viewModel)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: viewController,
                        withNextStepper: viewModel),
            .contribute(withNextPresentable: viewController,
                        withNextStepper: activeStepper)
        ])
    }
}
