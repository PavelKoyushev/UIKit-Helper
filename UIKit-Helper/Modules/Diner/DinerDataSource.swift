//
//  DinerDataSource.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 09.11.2023.
//

import UIKit
import RxDataSources
import RxCocoa

enum DinerScreenItem {
    
    case image(model: String)
    case description(model: String)
}

final class DinerDataSource {
    
    typealias SectionType = SectionModel<String, DinerScreenItem>
    typealias DataSource = RxTableViewSectionedReloadDataSource<SectionType>
    
    let dataSource = DataSource { (dataSource, tableView, indexPath, _) -> UITableViewCell in
        switch dataSource[indexPath] {
        case let .image(model: model):
            CodeCellBuilder<ImageTableViewCell>.build(tableView: tableView,
                                                      indexPath: indexPath,
                                                      model: model)
        case let .description(model: model):
            CellBuilder<DinerInfoTableViewCell>.build(tableView: tableView,
                                                      indexPath: indexPath,
                                                      model: model)
        }
    }
}

struct DinerScreenBuilder {
    
    typealias SectionType = SectionModel<String, DinerScreenItem>
    
    static func build(diner: Diner) -> [SectionType] {
        
        var items = [DinerScreenItem]()
        
        let image = DinerScreenItem.image(model: diner.image)
        items.append(image)
        
        let description = DinerScreenItem.description(model: diner.description)
        items.append(description)
        
        let sections = [SectionType(model: "DinerInfo",
                                    items: items)]
        
        return sections
    }
}
