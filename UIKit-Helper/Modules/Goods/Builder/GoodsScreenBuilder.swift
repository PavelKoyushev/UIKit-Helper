//
//  GoodsScreenBuilder.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 18.06.2025.
//

import RxDataSources
import RxRelay

enum GoodsScreenItem {
    case sortingItem(model: SortingGoodsCellModel)
    case goodsItem(model: GoodsTableViewCellModel)
}

struct GoodsScreenBuilder {
    
    typealias SectionType = SectionModel<String, GoodsScreenItem>
    
    static func build(sortingType: SortType,
                      sortTap: PublishRelay<SortType>,
                      goods: [Goods]) -> [SectionType] {
        
        var items = [GoodsScreenItem]()
        let model = SortingGoodsCellModel(sortType: sortingType,
                                          sortButtonTap: sortTap)
        
        items.append(GoodsScreenItem.sortingItem(model: model))
        
        for i in goods {
            items.append(GoodsScreenItem.goodsItem(model: GoodsTableViewCellModel(name: i.name,
                                                                                  price: i.price,
                                                                                  description: i.description)))
        }
        
        let sections = [SectionType(model: "Goods", items: items)]
        
        return sections
    }
}
