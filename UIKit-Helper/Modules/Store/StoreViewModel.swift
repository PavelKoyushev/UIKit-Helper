//
//  StoreViewModel.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 27.10.2023.
//

import RxSwift
import RxCocoa
import RxFlow
import RxDataSources

final class StoreViewModel: Stepper {
    
    let disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()
    
    struct Input {
        let onDidLoad: Observable<Void>
    }
    
    struct Output {
        
    }
}
