//
//  TrialView.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 11.07.2025.
//

import UIKit

final class TrialView: UIView {
    
    private lazy var titleLabel = UILabel()
    private lazy var subtitleLabel = UILabel()
    private lazy var imageView = UIImageView()
    
    private lazy var textStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
}

extension TrialView {
    
    func configure(with model: FreeTrialModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subTitle
        imageView.image = UIImage(named: "collage")
    }
}

private extension TrialView {
    
    func makeConstraints() {
        textStack.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textStack)
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            textStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22),
            textStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            imageView.leadingAnchor.constraint(equalTo: textStack.trailingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19)
        ])
    }
    
    func setupUI() {
        backgroundColor = UIColor(named: "trialViewColor")
        layer.cornerRadius = 12
        clipsToBounds = true
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        subtitleLabel.textColor = .white
        subtitleLabel.font = UIFont.systemFont(ofSize: 13)
        subtitleLabel.numberOfLines = 0
        
        imageView.contentMode = .scaleAspectFit
    }
}
