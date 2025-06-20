//
//  GoodsTableViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 18.06.2025.
//

import UIKit

final class GoodsTableViewCell: UITableViewCell, CodeCellConfigurable {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "goodsCellColor")
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var priceLabel: PriceView = {
        let label = PriceView()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let spacer = UIView()
        let stack = UIStackView(arrangedSubviews: [nameLabel, spacer, priceLabel])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = 12
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
    
    func configureCell(with model: GoodsTableViewCellModel) {
        nameLabel.text = model.name
        priceLabel.configure(with: model.price)
    }
}

private extension GoodsTableViewCell {
    
    func makeConstraints() {
        contentView.addSubview(containerView)
        containerView.addSubview(horizontalStack)
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        horizontalStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configureUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
