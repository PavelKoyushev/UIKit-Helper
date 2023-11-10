//
//  DinerViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 30.10.2023.
//

import UIKit
import RxSwift
import RxRelay

final class DinerViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: DinerViewModel!
    
    private var input: DinerViewModel.Input!
    private var output: DinerViewModel.Output!
    
    private lazy var tableView = UITableView()
    
    private let onDidLoad = PublishRelay<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindUI()
        
        onDidLoad.accept(())
    }
    
    func inject(viewModel: DinerViewModel) {
        self.viewModel = viewModel
    }
}

private extension DinerViewController {
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        makeConstraints()
        configureTableView()
    }
    
    func makeConstraints() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureTableView() {
        tableView.do {
            $0.register(cellType: ImageTableViewCell.self)
            $0.register(cellType: DinerInfoTableViewCell.self)
            $0.backgroundColor = .white
            $0.tableFooterView = UIView()
            $0.showsVerticalScrollIndicator = false
            $0.bounces = true
            $0.separatorStyle = .none
            $0.rowHeight = UITableView.automaticDimension
        }
    }
}

private extension DinerViewController {
    
    func bindUI() {
        bindViewModel()
        bindTableView()
    }
    
    func bindViewModel() {
        let input = DinerViewModel.Input(onDidLoad: onDidLoad.asObservable())
        output = viewModel.transform(input: input)
    }
    
    func bindTableView() {
        output.sections
            .drive(tableView.rx.items(dataSource: output.dataSource))
            .disposed(by: disposeBag)
    }
}
