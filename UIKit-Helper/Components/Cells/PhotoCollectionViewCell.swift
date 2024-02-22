//
//  PhotoCollectionViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 02.05.2022.
//

import UIKit
import Then

final class PhotoCollectionViewCell: UICollectionViewCell, CodeCellConfigurable {
    
    private let imageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: PhotoCollectionViewCellModel) {
        
        imageView.image = UIImage(named: model.image)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
}

private extension PhotoCollectionViewCell {
    
    func configureUI() {
        
        configureImageView()
    }
    
    func configureImageView() {
        contentView.addSubview(imageView)
    }
}
