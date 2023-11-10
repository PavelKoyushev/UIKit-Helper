//
//  CellBuilder.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 20.04.2022.
//

import UIKit
import Reusable
import RxRelay

protocol CodeCellConfigurable: Reusable {
    associatedtype Model
    func configureCell(with model: Model)
}

protocol CellConfigurable: NibReusable {
    associatedtype Model
    func configureCell(with model: Model)
}

protocol SelectedCodeCellConfigurable: Reusable {
    associatedtype Model
    associatedtype SelectedModel
    func configureCell(with model: Model, selected: PublishRelay<SelectedModel>)
}

final class CodeCellBuilder<T: CodeCellConfigurable> where T: UITableViewCell {

    static func build(tableView: UITableView,
                      indexPath: IndexPath,
                      model: T.Model) -> T {
        let cell = tableView.dequeueReusableCell(for: indexPath,
                                                 cellType: T.self)
        cell.configureCell(with: model)
        cell.selectionStyle = .none
        return cell
    }
}

final class CellBuilder<T: CellConfigurable> where T: UITableViewCell {

    static func build(tableView: UITableView, indexPath: IndexPath, model: T.Model) -> T {
        let cell = tableView.dequeueReusableCell(for: indexPath,
                                                 cellType: T.self)
        cell.configureCell(with: model)
        cell.selectionStyle = .none
        return cell
    }
}

final class CodeSelectedCellBuilder<T: SelectedCodeCellConfigurable> where T: UITableViewCell {

    static func build(tableView: UITableView,
                      indexPath: IndexPath,
                      model: T.Model,
                      selected: PublishRelay<T.SelectedModel>) -> T {
        let cell = tableView.dequeueReusableCell(for: indexPath,
                                                 cellType: T.self)
        cell.configureCell(with: model,
                           selected: selected)
        cell.selectionStyle = .none
        return cell
    }
}
