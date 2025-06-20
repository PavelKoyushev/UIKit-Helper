//
//  SortingGoodsCellModel.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 19.06.2025.
//

import RxRelay

struct SortingGoodsCellModel {
    let sortType: SortType
    let sortButtonTap: PublishRelay<SortType>
}
