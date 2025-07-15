//
//  PicturesView.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 13.07.2025.
//

import UIKit

final class PicturesView: UIView {
    
    private var collectionView: UICollectionView!
    
    private var images: [PictureModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PicturesView {
    
    func configure(with model: [PictureModel]) {
        images = model
        collectionView.reloadData()
    }
}

private extension PicturesView {
    
    func configureCollectionView() {
        backgroundColor = UIColor(named: "bgColor")
        
        let layout = PicturesViewLayout()
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.register(PictureCollectionViewCell.self,
                                forCellWithReuseIdentifier: PictureCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(named: "bgColor")
        
        addSubview(collectionView)
    }
}

extension PicturesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! PictureCollectionViewCell
        cell.configure(name: images[indexPath.item].name)
        return cell
    }
}
