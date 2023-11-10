//
//  RatingView.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 27.10.2023.
//

import UIKit

final class RatingView: UIView {
    
    private lazy var stackView = UIStackView()
    private var rating: Int = 0
    
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
    
    func setRating(value: Int) {
        rating = value
    }
}

private extension RatingView {
    
    func makeConstraints() {
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
    
    func configureUI() {
        
        stackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
        }
        
        for i in 1...5 {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.image = UIImage(systemName: "star.fill")
            
            if i <= rating {
                image.tintColor = .orange
            } else {
                image.tintColor = .gray
            }
            
            stackView.addArrangedSubview(image)
        }
    }
}
