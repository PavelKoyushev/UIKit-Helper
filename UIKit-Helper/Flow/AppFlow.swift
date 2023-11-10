//
//  AppFlow.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 16.10.2023.
//

import UIKit
import RxFlow
import RxCocoa

final class AppFlow: Flow {
    
    var root: Presentable {
        return self.rootWindow
    }
    
    private let rootWindow: UIWindow
    
    private let activeStepper: ActiveStepper
    
    init(withWindow window: UIWindow,
         activeStepper: ActiveStepper) {
        
        self.rootWindow = window
        self.activeStepper = activeStepper
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return FlowContributors.none }
        
        switch step {
        case .dashboard:
            return navigateToDashboardFlow()
       
        default:
            return FlowContributors.none
        }
    }
    
    private func navigateToDashboardFlow() -> FlowContributors {
        let dashboard = DashboardFlow(activeStepper: activeStepper)
        
        Flows.use(dashboard, when: .ready) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }

        return .one(flowContributor: .contribute(withNextPresentable: dashboard,
                                                 withNextStepper: OneStepper(withSingleStep: AppStep.dashboard)))
    }
}
