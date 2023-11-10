//
//  ActiveStepper.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 16.10.2023.
//

import RxFlow
import RxCocoa
import RxSwift

final class ActiveStepper: Stepper {

    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    var initialStep: Step {
        return AppStep.dashboard
    }

    func readyToEmitSteps() {

    }
}
