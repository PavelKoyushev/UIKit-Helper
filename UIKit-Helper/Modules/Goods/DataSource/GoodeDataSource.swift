//
//  GoodeDataSource.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 18.06.2025.
//

import UIKit
import RxDataSources
import RxCocoa

final class GoodsScreenDataSource {
    
    typealias SectionType = SectionModel<String, GoodsScreenItem>
    typealias DataSource = RxTableViewSectionedReloadDataSource<SectionType>
    
    let dataSource = DataSource { (dataSource, tableView, indexPath, _) -> UITableViewCell in
        switch dataSource[indexPath] {
            
        case .sortingItem(model: let model):
            return CodeCellBuilder<SortingGoodsTableViewCell>.build(tableView: tableView,
                                                                    indexPath: indexPath,
                                                                    model: model)
        case .goodsItem(model: let model):
            return CodeCellBuilder<GoodsTableViewCell>.build(tableView: tableView,
                                                             indexPath: indexPath,
                                                             model: model)
        }
    }
}
