//
//  GoodsViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 18.06.2025.
//

import UIKit
import RxSwift
import RxRelay

final class GoodsViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    private var viewModel: GoodsViewModel!
    
    private var input: GoodsViewModel.Input!
    private var output: GoodsViewModel.Output!
    
    private let onDidLoad = PublishRelay<Void>()
    
    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Products"
        
        configureUI()
        bindUI()

        onDidLoad.accept(())
    }
    
    func inject(viewModel: GoodsViewModel) {
        self.viewModel = viewModel
    }
}

private extension GoodsViewController {
    
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
            $0.register(cellType: SortingGoodsTableViewCell.self)
            $0.register(cellType: GoodsTableViewCell.self)
            $0.backgroundColor = .white
            $0.tableFooterView = UIView()
            $0.showsVerticalScrollIndicator = false
            $0.bounces = true
            $0.separatorStyle = .none
            $0.tableFooterView = UIView()
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 106
        }
    }
}

private extension GoodsViewController {
    
    func bindUI() {
        
        bindViewModel()
        bindTableView()
    }
    
    func bindViewModel() {
        
        let input = GoodsViewModel.Input(onDidLoad: onDidLoad.asObservable())
        output = viewModel.transform(input: input)
    }
    
    func bindTableView() {
        
        output.sections
            .drive(tableView.rx.items(dataSource: output.dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(GoodsScreenItem.self)
            .compactMap { item -> Goods? in
                switch item {
                case let .goodsItem(model: value):
                    return Goods(name: value.name,
                                 price: value.price,
                                 description: value.description)
                default:
                    return nil
                }
            }
            .subscribe(onNext: { [weak self] good in
                self?.presentPopup(for: good)
            })
            .disposed(by: disposeBag)
    }
    
    private func presentPopup(for good: Goods) {
        let popupVC = GoodsPopupViewController()
        popupVC.configure(with: good)
        
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.modalTransitionStyle = .crossDissolve
        
        present(popupVC, animated: true, completion: nil)
    }
}
