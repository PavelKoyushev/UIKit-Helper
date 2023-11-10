//
//  PromoCityCollectionViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 20.10.2023.
//

import UIKit

final class PromoCityCollectionViewCell: UICollectionViewCell, CodeCellConfigurable {
    
    private lazy var imageView = UIImageView()
    private lazy var stackView = UIStackView()
    private lazy var cityLabel = UILabel()
    private lazy var countryLabel = UILabel()
    
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
    
    func configureCell(with model: PromoCityCellProtocol) {
        
        imageView.image = UIImage(named: model.imageName)
        cityLabel.text = model.city
        countryLabel.text = model.country
    }
}

private extension PromoCityCollectionViewCell {
    
    func makeConstraints() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(2)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(4)
            $0.height.equalTo(30)
        }
    }
    
    func configureUI() {
        
        contentView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 8
            $0.layer.shadowColor = UIColor.darkGray.cgColor
            $0.layer.shadowRadius = 4
            $0.layer.shadowOpacity = 0.3
            $0.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        }
        
        imageView.do {
            $0.contentMode = .scaleToFill
            $0.layer.cornerRadius = 4
            $0.clipsToBounds = true
        }
        
        cityLabel.do {
            $0.font = .systemFont(ofSize: 13, weight: .bold)
            $0.textColor = .black
        }
        
        countryLabel.do {
            $0.font = .systemFont(ofSize: 11, weight: .regular)
            $0.textColor = .black
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.spacing = 1
            $0.addArrangedSubview(cityLabel)
            $0.addArrangedSubview(countryLabel)
            $0.alignment = .top
        }
    }
}

#if DEBUG

import SwiftUI
import Reusable

struct PromoCityCollectionViewCellPreview: UIViewRepresentable {
    let viewBuilder: () -> UICollectionViewCell

    init(_ viewBuilder: @escaping () -> UICollectionViewCell) {
        self.viewBuilder = viewBuilder
    }

    func makeUIView(context: Context) -> some UICollectionViewCell {
        viewBuilder()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Not needed
    }
}

struct PromoCityCollectionViewCell_Preview: PreviewProvider {

    static var previews: some View {

        PromoCityCollectionViewCellPreview {

            PromoCityCollectionViewCell(frame: .zero)
        }
    }
}
#endif
