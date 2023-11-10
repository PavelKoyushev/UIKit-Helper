//
//  DinerTableViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 23.10.2023.
//

import UIKit
import RxSwift
import RxRelay

class DinerTableViewCell: UITableViewCell, SelectedCodeCellConfigurable {
    
    private let disposeBag = DisposeBag()
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: .init())
    
    private let collectionItems = BehaviorRelay<[Diner]>(value: [])
    private let selectedCell = PublishRelay<Diner>()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
        bindCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        configureUI()
    }
    
    func configureCell(with model: [Diner],
                       selected: PublishRelay<Diner>) {
        
        collectionItems.accept(model)
        
        selectedCell
            .bind(to: selected)
            .disposed(by: disposeBag)
    }
}

private extension DinerTableViewCell {
    
    func makeConstraints() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(104)
        }
    }
    
    func configureUI() {
        
        collectionView.do {
            $0.collectionViewLayout = collectionViewLayout()
            $0.register(cellType: DinerCollectionViewCell.self)
            $0.showsHorizontalScrollIndicator = false
            $0.allowsMultipleSelection = false
            $0.backgroundColor = .white
        }
        
        func collectionViewLayout() -> UICollectionViewFlowLayout {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            layout.minimumInteritemSpacing = 10
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.7,
                                     height: 96)
            layout.sectionInset = UIEdgeInsets(top: 0.0,
                                               left: 16.0,
                                               bottom: 0.0,
                                               right: 16.0)
            return layout
        }
    }
}

private extension DinerTableViewCell {
    
    func bindCollectionView() {
        
        collectionItems
            .bind(to: collectionView.rx.items(cellIdentifier: DinerCollectionViewCell.reuseIdentifier,
                                              cellType: DinerCollectionViewCell.self)) { _, model, cell in
                cell.configureCell(with: model)
            }
            .disposed(by: disposeBag)
        
        collectionView
            .rx
            .modelSelected(Diner.self)
            .asObservable()
            .bind(to: selectedCell)
            .disposed(by: disposeBag)
    }
}
