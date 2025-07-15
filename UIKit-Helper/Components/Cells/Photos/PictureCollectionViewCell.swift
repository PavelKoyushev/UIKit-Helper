//
//  PictureCollectionViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 14.07.2025.
//

import UIKit

final class PictureCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: PictureCollectionViewCell.self)
    
    private lazy var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
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
    }
}

extension PictureCollectionViewCell {
    
    func configure(name: String) {
        imageView.image = UIImage(named: name)
    }
}

private extension PictureCollectionViewCell {
    
    func configureUI() {
        imageView.frame = contentView.bounds
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
}
