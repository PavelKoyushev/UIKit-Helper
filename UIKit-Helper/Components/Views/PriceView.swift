//
//  PriceView.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 19.06.2025.
//

import UIKit
import SnapKit

final class PriceView: UIView {
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "₽"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(priceLabel)
        addSubview(currencyLabel)
        
        priceLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        
        currencyLabel.snp.makeConstraints {
            $0.leading.equalTo(priceLabel.snp.trailing).offset(4)
            $0.firstBaseline.equalTo(priceLabel.snp.firstBaseline)
            $0.trailing.equalToSuperview()
        }
    }
    
    func configure(with price: Double, isBold: Bool = false) {
        priceLabel.text = String(format: "%.2f", price)
        if isBold {
            priceLabel.font = .boldSystemFont(ofSize: 16)
        }
    }
}
