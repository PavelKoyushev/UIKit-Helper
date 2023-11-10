//
//  DinerViewModel.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 02.11.2023.
//

import RxSwift
import RxCocoa
import RxFlow
import RxDataSources

final class DinerViewModel: Stepper {
    
    let disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()
    
    
    struct Input {
        let onDidLoad: Observable<Void>
    }
    
    struct Output {
        let sections: Driver<[DinerDataSource.SectionType]>
        let dataSource = DinerDataSource().dataSource
    }
    
    private let diner: Diner
    
    init(diner: Diner) {
        self.diner = diner
    }
}

extension DinerViewModel {
    
    typealias SectionType = SectionModel<String, DinerScreenItem>
    
    func transform(input: Input) -> Output {
        
        let sections = BehaviorRelay<[SectionType]>(value: [])
        
        let screen = Observable.combineLatest(input.onDidLoad,
                                              Observable.just(diner))
        
        screen
            .map {
                DinerScreenBuilder.build(diner: $0.1)
            }
            .bind(to: sections)
            .disposed(by: disposeBag)
        
        let output = Output(sections: sections.asDriver(onErrorJustReturn: []))
        
        return output
    }
}
