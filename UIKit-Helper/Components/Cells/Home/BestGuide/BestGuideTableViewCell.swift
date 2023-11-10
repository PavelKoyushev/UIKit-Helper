//
//  BestGuideTableViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 24.10.2023.
//

import UIKit
import RxSwift
import RxRelay

final class BestGuideTableViewCell: UITableViewCell, CodeCellConfigurable {
    
    private let disposeBag = DisposeBag()
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: .init())
    
    private let collectionItems = BehaviorRelay<[BestGuide]>(value: [])
    
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
    
    func configureCell(with model: [BestGuide]) {
        collectionItems.accept(model)
    }
}

private extension BestGuideTableViewCell {
    
    func configureUI() {
        
        collectionView.do {
            $0.register(cellType: BestGuideCollectionViewCell.self)
            $0.collectionViewLayout = BestGuidesFlowLayout()
            $0.alwaysBounceVertical = true
            $0.bounces = true
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
        }
    }
    
    func makeConstraints() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(210)
            $0.edges.equalToSuperview()
        }
    }
    
    func bindCollectionView() {
        
        collectionItems
            .bind(to: collectionView.rx.items(cellIdentifier: BestGuideCollectionViewCell.reuseIdentifier,
                                              cellType: BestGuideCollectionViewCell.self)) { _, model, cell in
                cell.configureCell(with: model)
            }
            .disposed(by: disposeBag)
    }
}
