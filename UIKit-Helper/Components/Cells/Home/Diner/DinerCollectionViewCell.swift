//
//  DinerCollectionViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 23.10.2023.
//

import UIKit

final class DinerCollectionViewCell: UICollectionViewCell, CodeCellConfigurable {
    
    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var subTitleLabel = UILabel()
    private lazy var ratingView = RatingView()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
    }
    
    func configureCell(with model: DinerCellProtocol) {
        
        imageView.image = UIImage(named: model.image)
        titleLabel.text = model.title
        subTitleLabel.text = model.subtitle
        
        ratingView.setRating(value: model.rating)
    }
}

private extension DinerCollectionViewCell {
    
    func makeConstraints() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(ratingView)
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.height.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView).offset(6)
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        ratingView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(2)
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.width.equalTo(90)
        }
    }
    
    func configureUI() {
        
        contentView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 16
            $0.layer.shadowColor = UIColor.darkGray.cgColor
            $0.layer.shadowRadius = 4
            $0.layer.shadowOpacity = 0.3
            $0.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        }
        
        imageView.do {
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 4
            $0.clipsToBounds = true
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.textColor = .black
            $0.numberOfLines = 1
        }
        
        subTitleLabel.do {
            $0.font = .systemFont(ofSize: 12, weight: .medium)
            $0.textColor = .black
            $0.numberOfLines = 2
        }
    }
}
