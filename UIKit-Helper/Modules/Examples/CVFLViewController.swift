//
//  CVFLViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 30.08.2022.
//

import UIKit

class CVFLViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = PizzaFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = AppColor.premiumPizza
        collectionView.register(cellType: ProductCollectionViewCell.self)
        return collectionView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.text = "Premium Pizza"
        return label
    }()
    
    private let products = [
        Product(image: "img1", title: "Pizza Hot", price: 950.70),
        Product(image: "img2", title: "Pizza Heat", price: 850.00),
        Product(image: "img3", title: "Pizza Lot", price: 452.70),
        Product(image: "img4", title: "Pizza Boom", price: 750.70),
        Product(image: "img5", title: "Pizza Red", price: 680.30)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColor.premiumPizza
        collectionView.dataSource = self
        configureUI()
    }
}

private extension CVFLViewController {
    
    func configureUI() {

        configureCollectionView()
        makeConstraints()
    }
    
    func configureCollectionView() {
        
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    func makeConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}

extension CVFLViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ProductCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        let model = ProductCellModel(image: products[indexPath.row].image,
                                     title: products[indexPath.row].title,
                                     price: products[indexPath.row].price)
        
        cell.configureCell(with: model)
        
        return cell
    }
}
