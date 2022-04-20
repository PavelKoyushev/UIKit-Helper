//
//  CellBuilder.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 20.04.2022.
//

import UIKit
import Reusable

protocol CodeCellConfigurable: Reusable {
    associatedtype Model
    func configureCell(with model: Model)
}

final class CodeCellBuilder<T: CodeCellConfigurable> where T: UITableViewCell {

    static func build(tableView: UITableView, indexPath: IndexPath, model: T.Model) -> T {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: T.self)
        cell.configureCell(with: model)
        cell.selectionStyle = .none
        return cell
    }
}
