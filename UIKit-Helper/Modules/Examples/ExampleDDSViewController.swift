//
//  ExampleDDSViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 20.04.2022.
//

import UIKit

final class ExampleDDSViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(cellType: ContactTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    enum Section {
        case developers
    }
    
    private let developers = [
        Developer(name: "Joe", grade: "Senior"),
        Developer(name: "Boe", grade: "Middle+"),
        Developer(name: "Toe", grade: "Junior+"),
    ]
    
    private var dataSource: UITableViewDiffableDataSource<Section, Developer>!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        configureDataSource()
        createSnapshot(data: developers)
    }

}

private extension ExampleDDSViewController {
    
    func configureUI() {
        
        configureTableView()
        makeConstraints()
    }
    
    func configureTableView() {
        
        view.addSubview(tableView)
    }
    
    func makeConstraints() {
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

private extension ExampleDDSViewController {
    
    func configureDataSource(){
        
        dataSource = UITableViewDiffableDataSource<Section, Developer>(tableView: tableView, cellProvider: { (tableview, indexpath, model) -> UITableViewCell? in
            let cell: ContactTableViewCell  = tableview.dequeueReusableCell(for: indexpath)
            
            let cellModel = ContactTableViewCellModel(name: model.name,
                                                      grade: model.grade)
            
            cell.configureCell(with: cellModel)
            
            return cell
        })
    }
    
    func createSnapshot(data: [Developer]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Developer>()
        
        snapshot.appendSections([.developers])
        snapshot.appendItems(data)
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}
