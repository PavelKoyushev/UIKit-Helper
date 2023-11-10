//
//  StoreViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 27.10.2023.
//

import UIKit
import RxSwift
import RxRelay

final class StoreViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: StoreViewModel!
    
    private var input: StoreViewModel.Input!
    private var output: StoreViewModel.Output!
    
    private let onDidLoad = PublishRelay<Void>()
    
    private lazy var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        onDidLoad.accept(())
    }
    
    func inject(viewModel: StoreViewModel) {
        self.viewModel = viewModel
    }
}
