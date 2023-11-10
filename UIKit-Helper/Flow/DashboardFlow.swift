//
//  DashboardFlow.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 16.10.2023.
//

import UIKit
import RxFlow
import RxCocoa

final class DashboardFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    let rootViewController: UITabBarController = {
        let viewController = UITabBarController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .flipHorizontal
        return viewController
    }()
    
    private let activeStepper: ActiveStepper
    
    private let homeFlow: HomeFlow
    private let storeFlow: StoreFlow
    private let otherFlow: OtherFlow
    
    init(activeStepper: ActiveStepper) {
        self.activeStepper = activeStepper
        
        self.homeFlow = HomeFlow(activeStepper: activeStepper)
        self.storeFlow = StoreFlow(activeStepper: activeStepper)
        self.otherFlow = OtherFlow(activeStepper: activeStepper)
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .dashboard:
            return navigateToDashboard()
        default:
            return .none
        }
    }
    
    private func navigateToDashboard() -> FlowContributors {
        
        Flows.use(homeFlow,
                  storeFlow,
                  otherFlow,
                  when: .ready) { [unowned self] (root1: UINavigationController,
                                                  root2: UINavigationController,
                                                  root3: UINavigationController) in
            
            let tabBarItem1 = UITabBarItem(title: "Home",
                                           image: UIImage(systemName: "globe.asia.australia"),
                                           selectedImage: UIImage(systemName: "globe.asia.australia"))
            
            let tabBarItem2 = UITabBarItem(title: "Store",
                                           image: UIImage(systemName: "bag.circle"),
                                           selectedImage: UIImage(systemName: "bag.circle"))
            
            let tabBarItem3 = UITabBarItem(title: "Other",
                                           image: UIImage(systemName: "bag.circle"),
                                           selectedImage: UIImage(systemName: "bag.circle"))
            
            root1.tabBarItem = tabBarItem1
            root2.tabBarItem = tabBarItem2
            root3.tabBarItem = tabBarItem3
            
            rootViewController.setViewControllers([root1, root2, root3], animated: true)
        }
        
        return .multiple(flowContributors: [.contribute(withNextPresentable: homeFlow,
                                                        withNextStepper: OneStepper(withSingleStep: AppStep.home)),
                                            .contribute(withNextPresentable: storeFlow,
                                                        withNextStepper: OneStepper(withSingleStep: AppStep.store)),
                                            .contribute(withNextPresentable: otherFlow,
                                                        withNextStepper: OneStepper(withSingleStep: AppStep.other))])
    }
}
