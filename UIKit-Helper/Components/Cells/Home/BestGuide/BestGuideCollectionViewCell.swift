//
//  BestGuideCollectionViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 24.10.2023.
//

import UIKit

final class BestGuideCollectionViewCell: UICollectionViewCell, CodeCellConfigurable {
    
    lazy var shadowView = UIView()
    lazy var imageView = UIImageView()
    lazy var nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    func configureCell(with model: BestGuideProtocol) {
        
        imageView.image = UIImage(named: model.photo)
        nameLabel.text = model.name
    }
}

private extension BestGuideCollectionViewCell {
    
    func configureUI() {
        
        contentView.do {
            $0.backgroundColor = .white
        }
        
        shadowView.do {
            $0.backgroundColor = .clear
            $0.layer.shadowColor = UIColor.darkGray.cgColor
            $0.layer.shadowRadius = 4
            $0.layer.shadowOpacity = 0.3
            $0.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        }
        
        imageView.do {
            $0.contentMode = .scaleToFill
            $0.layer.cornerRadius = 35
            $0.clipsToBounds = true
        }
        
        nameLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.textColor = .black
            $0.textAlignment = .center
            $0.numberOfLines = 1
        }
    }
    
    func makeConstraints() {
        
        contentView.addSubview(shadowView)
        shadowView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        shadowView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(70)
            $0.height.equalTo(70)
            $0.top.equalToSuperview().inset(4)
            $0.bottom.equalTo(nameLabel.snp.top).offset(4)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalTo(shadowView)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.equalTo(imageView.snp.centerX)
            $0.horizontalEdges.equalToSuperview().inset(4)
            $0.bottom.equalToSuperview().offset(4)
        }
    }
}
