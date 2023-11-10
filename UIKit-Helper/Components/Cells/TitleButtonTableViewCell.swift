//
//  TitleButtonTableViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 25.10.2023.
//

import UIKit

final class TitleButtonTableViewCell: UITableViewCell, CodeCellConfigurable {

    private lazy var titleLabel = UILabel()
    private lazy var allLabel = UILabel()
    private lazy var image = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    func configureCell(with model: TitleButtonCellProtocol) {
        
        titleLabel.text = model.title
    }
}

private extension TitleButtonTableViewCell {
    
    func makeConstraints() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(allLabel)
        contentView.addSubview(image)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(allLabel.snp.leading)
            $0.verticalEdges.equalToSuperview().inset(12)
        }
        
        allLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(18)
        }
        
        image.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(allLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(12)
            $0.height.equalTo(18)
        }
    }
    
    func configureUI() {
        
        contentView.do {
            $0.backgroundColor = .white
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.textColor = .black
            $0.textAlignment = .left
            $0.numberOfLines = 1
        }
        
        allLabel.do {
            $0.text = "all"
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.textColor = .black
            $0.textAlignment = .center
        }
        
        image.do {
            $0.image = UIImage(systemName: "chevron.right")
            $0.tintColor = .black
        }
    }
}
