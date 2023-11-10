//
//  PromoCityTableViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 21.10.2023.
//

import UIKit
import RxSwift
import Reusable
import RxRelay

final class PromoCityTableViewCell: UITableViewCell, CodeCellConfigurable {
    
    private let disposeBag = DisposeBag()
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: .init())
    
    private let collectionItems = BehaviorRelay<[PromoTourModel]>(value: [])

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
        bindCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        
        configureUI()
    }
    
    func configureCell(with model: [PromoTourModel]) {
        
        collectionItems.accept(model)
    }
}

private extension PromoCityTableViewCell {
    
    func makeConstraints() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(138)
        }
    }
    
    func configureUI() {
        
        collectionView.do {
            $0.collectionViewLayout = collectionViewLayout()
            $0.register(cellType: PromoCityCollectionViewCell.self)
            $0.showsHorizontalScrollIndicator = false
            $0.allowsMultipleSelection = false
            $0.backgroundColor = .white
        }
        
        func collectionViewLayout() -> UICollectionViewFlowLayout {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            layout.minimumInteritemSpacing = 10
            layout.itemSize = CGSize(width: 106,
                                     height: 132)
            layout.sectionInset = UIEdgeInsets(top: 0.0,
                                               left: 16.0,
                                               bottom: 0.0,
                                               right: 16.0)
            return layout
        }
    }
}

private extension PromoCityTableViewCell {
    
    func bindCollectionView() {
        
        collectionItems
            .bind(to: collectionView.rx.items(cellIdentifier: PromoCityCollectionViewCell.reuseIdentifier,
                                              cellType: PromoCityCollectionViewCell.self)) { _, model, cell in
                cell.configureCell(with: model)
            }
            .disposed(by: disposeBag)
    }
}
