//
//  PicturesViewLayout.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 14.07.2025.
//

import UIKit

final class PicturesViewLayout: UICollectionViewLayout {
    
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 8
    private let edgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16)
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.width - (edgeInsets.left + edgeInsets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.bounds.width ?? 0, height: contentHeight + edgeInsets.bottom)
    }
    
    override func prepare() {
        guard let collectionView = collectionView, cache.isEmpty else { return }
        
        let columnWidth = (contentWidth - CGFloat(numberOfColumns - 1) * cellPadding) / CGFloat(numberOfColumns)
        
        let xOffset = (0..<numberOfColumns).map {
            edgeInsets.left + CGFloat($0) * (columnWidth + cellPadding)
        }
        
        var yOffset = Array(repeating: edgeInsets.top, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let itemHeight: CGFloat = item % 2 == 0 ? 220 : 196
            let column = yOffset.enumerated().min(by: { $0.element < $1.element })!.offset
            
            let frame = CGRect(
                x: xOffset[column],
                y: yOffset[column],
                width: columnWidth,
                height: itemHeight
            )
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            
            yOffset[column] = frame.maxY + cellPadding
            contentHeight = max(contentHeight, yOffset[column])
        }
        
        contentHeight += edgeInsets.top
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        cache.filter {
            $0.frame.intersects(rect)
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        cache.first {
            $0.indexPath == indexPath
        }
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        cache.removeAll()
        contentHeight = 0
    }
}
