//
//  HomeFlow.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 16.10.2023.
//

import Foundation

import UIKit
import RxFlow
import RxCocoa

final class HomeFlow: Flow {
    
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
        case .home:
            return homeScreen()
        case let .diner(model: diner):
            return dinerScreen(diner: diner)
        default:
            return .none
        }
    }
    
    private func dinerScreen(diner: Diner) -> FlowContributors {
        let viewController = DinerViewController()
        let viewModel = DinerViewModel(diner: diner)
        
        viewController.inject(viewModel: viewModel)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: viewController,
                                                     withNextStepper: viewModel),
            .contribute(withNextPresentable: viewController,
                                                     withNextStepper: activeStepper)
        ])
    }
    
    private func homeScreen() -> FlowContributors {
        
        let viewController = HomeViewController()
        let viewModel = HomeViewModel()
        
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
