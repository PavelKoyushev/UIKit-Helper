//
//  TagsView.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 12.07.2025.
//

import UIKit

final class TagsView: UIView {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    private var array: [TagModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
extension TagsView {
    
    func configure(with model: [TagModel]) {
        array = model
        collectionView.reloadData()
    }
}

private extension TagsView {
    
    func makeConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    func setupUI() {
        backgroundColor = UIColor(named: "bgColor")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(named: "bgColor")
        collectionView.register(TagCollectionViewCell.self,
                                forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
        collectionView.alwaysBounceVertical = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        collectionView.collectionViewLayout = layout
    }
}

extension TagsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! TagCollectionViewCell
        cell.configure(with: array[indexPath.item].title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let text = array.get(indexPath.item)?.title else {
            return .zero
        }
        
        let font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        let padding: CGFloat = 12 + 12
        let height: CGFloat = 25
        
        let size = text.size(withAttributes: [.font: font])
        
        return CGSize(width: size.width + padding, height: height)
    }
}
