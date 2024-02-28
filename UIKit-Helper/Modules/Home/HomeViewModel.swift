//
//  HomeViewModel.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 16.10.2023.
//

import RxSwift
import RxCocoa
import RxFlow
import RxDataSources

final class HomeViewModel: Stepper {
    
    let disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()
    
    private let tours: [PromoTourModel] = PromoTourModel.mockArray
    private let diners: [Diner] = Diner.mockArray
    private let guides: [BestGuide] = BestGuide.mockArray
    private let membershipStatus: MembershipStatus = .mock
    
    struct Input {
        let onDidLoad: Observable<Void>
    }
    
    struct Output {
        let sections: Driver<[HomeScreenDataSource.SectionType]>
        let dataSource = HomeScreenDataSource().dataSource
    }
}

extension HomeViewModel {
    
    typealias SectionType = SectionModel<String, HomeScreenItem>
    
    func transform(input: Input) -> Output {
        
        let sections = BehaviorRelay<[SectionType]>(value: [])
        
        let popularCities = BehaviorRelay<[PromoTourModel]>(value: [])
        let diners = BehaviorRelay<[Diner]>(value: [])
        let bestGuides = BehaviorRelay<[BestGuide]>(value: [])
        let status = BehaviorRelay<MembershipStatus>(value: .mock)
        
        let dinerTap = PublishRelay<Diner>()
        
        input.onDidLoad
            .map { [weak self] in
                self?.tours ?? []
            }
            .bind(to: popularCities)
            .disposed(by: disposeBag)
        
        input.onDidLoad
            .map { [weak self] in
                self?.guides ?? []
            }
            .bind(to: bestGuides)
            .disposed(by: disposeBag)
        
        input.onDidLoad
            .map { [weak self] in
                self?.diners ?? []
            }
            .bind(to: diners)
            .disposed(by: disposeBag)
        
        input.onDidLoad
            .map { [weak self] in
                self?.membershipStatus ?? .mock
            }
            .bind(to: status)
            .disposed(by: disposeBag)
        
        let screen = Observable.combineLatest(popularCities, diners, bestGuides, status)
        
        screen
            .map {
                HomeScreenBuilder.build(promoTour: $0.0,
                                        diner: $0.1,
                                        bestGuides: $0.2,
                                        selectedDiner: dinerTap,
                                        membershipStatus: $0.3)
            }
            .bind(to: sections)
            .disposed(by: disposeBag)
        
        dinerTap
            .map { AppStep.diner(model: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)
                                              
        let output = Output(sections: sections.asDriver(onErrorJustReturn: []))
        
        return output
    }
}
