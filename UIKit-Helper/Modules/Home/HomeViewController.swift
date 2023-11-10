//
//  HomeViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 16.10.2023.
//

import UIKit
import RxSwift
import RxRelay


final class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: HomeViewModel!
    
    private var input: HomeViewModel.Input!
    private var output: HomeViewModel.Output!
    
    private let onDidLoad = PublishRelay<Void>()
    
    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Travel"
        
        configureUI()
        bindUI()
        
        onDidLoad.accept(())
    }
    
    func inject(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
}

private extension HomeViewController {
    
    func configureUI() {
        
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
            $0.register(cellType: TitleButtonTableViewCell.self)
            $0.register(cellType: PromoCityTableViewCell.self)
            $0.register(cellType: DinerTableViewCell.self)
            $0.register(cellType: BestGuideTableViewCell.self)
            $0.backgroundColor = .white
            $0.tableFooterView = UIView()
            $0.showsVerticalScrollIndicator = false
            $0.bounces = true
            $0.separatorStyle = .none
            $0.rowHeight = UITableView.automaticDimension
        }
    }
}

private extension HomeViewController {
    
    func bindUI() {
        
        bindViewModel()
        bindTableView()
    }
    
    func bindViewModel() {
        
        let input = HomeViewModel.Input(onDidLoad: onDidLoad.asObservable())
        output = viewModel.transform(input: input)
    }
    
    func bindTableView() {
        
        output.sections
            .drive(tableView.rx.items(dataSource: output.dataSource))
            .disposed(by: disposeBag)
    }
}
