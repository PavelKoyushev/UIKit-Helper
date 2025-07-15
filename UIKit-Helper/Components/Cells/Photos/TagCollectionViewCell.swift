//
//  TagCollectionViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 11.07.2025.
//

import UIKit

final class TagCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: TagCollectionViewCell.self)
    
    private lazy var label = UILabel()
    
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
        label.text = nil
    }
}

extension TagCollectionViewCell {
    
    func configure(with text: String) {
        label.text = text
    }
}

private extension TagCollectionViewCell {
    
    func makeConstraints() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
    
    func configureUI() {
        contentView.backgroundColor = UIColor(named: "cellTagBGColor")
        contentView.layer.cornerRadius = 25 / 2
        contentView.clipsToBounds = true
        
        label.textColor = UIColor(named: "cellTagTextColor")
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.textAlignment = .center
        label.clipsToBounds = true
    }
}
