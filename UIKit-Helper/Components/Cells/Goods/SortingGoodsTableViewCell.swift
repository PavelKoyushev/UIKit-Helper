//
//  SortingGoodsTableViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 18.06.2025.
//

import UIKit
import RxSwift
import RxRelay

final class SortingGoodsTableViewCell: UITableViewCell, CodeCellConfigurable {
    
    private let disposeBag = DisposeBag()
    private lazy var button = BlueButton()
    
    private var buttonTap: PublishRelay<Void>!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureCell(with model: SortingGoodsCellModel) {
        
        button.setTitle(model.sortType.title, for: .normal)
        
        button.rx.tap
            .map { model.sortType }
            .bind(to: model.sortButtonTap)
            .disposed(by: disposeBag)
    }
}

private extension SortingGoodsTableViewCell {
    
    func makeConstraints() {
        contentView.addSubview(button)
        
        button.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalToSuperview().offset(32)
            $0.bottom.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().inset(32)
        }
    }
}
