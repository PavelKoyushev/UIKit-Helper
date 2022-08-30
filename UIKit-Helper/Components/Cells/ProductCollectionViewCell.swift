//
//  ProductCollectionViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 30.08.2022.
//

import UIKit

struct ProductCellModel {
    
    let image: String
    let title: String
    let price: Double
}

final class ProductCollectionViewCell: UICollectionViewCell, CodeCellConfigurable {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "map")
        view.backgroundColor = .lightGray
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pizza"
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: ProductCellModel) {
        
        imageView.image = UIImage(named: model.image)
        titleLabel.text = model.title
        priceLabel.text = String(model.price) + " ₽"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
    }
}

private extension ProductCollectionViewCell {
    
    func configureUI() {
        contentView.backgroundColor = .white
        configureViews()
        makeConstraints()
    }
    
    func configureViews() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    func makeConstraints() {
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}

#if DEBUG

import SwiftUI

struct ProductCollectionViewCellPreview: UIViewRepresentable {
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

struct ProductCollectionViewCell_Preview: PreviewProvider {

    static var previews: some View {

        ProductCollectionViewCellPreview {

            ProductCollectionViewCell(frame: .zero)
        }
    }
}
#endif

