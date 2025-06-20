//
//  GoodsViewModel.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 18.06.2025.
//

import RxSwift
import RxCocoa
import RxFlow
import RxDataSources

final class GoodsViewModel: Stepper {
    
    let disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()
    
    private let goodsService: GoodsServiceProtocol
    
    init(goodsService: GoodsServiceProtocol) {
        self.goodsService = goodsService
    }
    
    struct Input {
        let onDidLoad: Observable<Void>
    }
    
    struct Output {
        let sections: Driver<[GoodsScreenDataSource.SectionType]>
        let dataSource = GoodsScreenDataSource().dataSource
    }
    
    deinit {
        print("\(Self.self) deinited")
    }
}

extension GoodsViewModel {
    
    typealias SectionType = SectionModel<String, GoodsScreenItem>
    
    func transform(input: Input) -> Output {
        
        let sections = BehaviorRelay<[SectionType]>(value: [])
        
        let goodsList = BehaviorRelay<[Goods]>(value: [])
        
        let sorting = BehaviorRelay<SortType>(value: .alphabetical)
        let sortTap = PublishRelay<SortType>()
        
        input.onDidLoad
            .map { [unowned self] in
                self.goodsService.fetchGoods()
            }
            .bind(to: goodsList)
            .disposed(by: disposeBag)
        
        sortTap
            .withLatestFrom(goodsList) { ($0, $1) }
            .map { sortType in
                let sortedGoods: [Goods]
                switch sortType.0 {
                case .alphabetical:
                    sortedGoods = sortType.1.sorted { $0.name < $1.name }
                case .price:
                    sortedGoods = sortType.1.sorted { $0.price < $1.price }
                }
                return sortedGoods
            }
            .bind(to: goodsList)
            .disposed(by: disposeBag)
        
        sortTap
            .map { $0.toggled }
            .bind(to: sorting)
            .disposed(by: disposeBag)
        
        let model = Observable.combineLatest(sorting, goodsList)
        
        model
            .map {
                GoodsScreenBuilder.build(sortingType: $0.0,
                                         sortTap: sortTap,
                                         goods: $0.1)
            }
            .bind(to: sections)
            .disposed(by: disposeBag)
                                    
        let output = Output(sections: sections.asDriver(onErrorJustReturn: []))
        
        return output
    }
}
