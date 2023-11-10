//
//  BestGuidesFlowLayout.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 25.10.2023.
//

import UIKit

final class BestGuidesFlowLayout: UICollectionViewFlowLayout {
    
    private let cellHeight: CGFloat = 100
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let minColumnWidth = 70.0
        
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        
        let maxNumColumns = Int(availableWidth / minColumnWidth)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        
        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.sectionInset = UIEdgeInsets(top: 0.0,
                                         left: 16.0,
                                         bottom: 0.0,
                                         right: 16.0)
        
        self.sectionInsetReference = .fromSafeArea
    }
}
