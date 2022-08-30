//
//  PizzaFlowLayout.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 30.08.2022.
//

import UIKit

class PizzaFlowLayout: UICollectionViewFlowLayout {
    
    private let cellHeight: CGFloat = 300.0
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumColumns = 1
        
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        let insetVertical = (collectionView.bounds.height - cellHeight) / 2
        
        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInset = UIEdgeInsets(top: insetVertical,
                                         left: 10.0,
                                         bottom: insetVertical,
                                         right: 0.0)
        
        self.sectionInsetReference = .fromSafeArea
        
        self.minimumInteritemSpacing = 20
        self.scrollDirection = .horizontal
    }
}
