//
//  CompositionalLayoutViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 02.05.2022.
//

import UIKit
import Then

final class CompositionalLayoutViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.backgroundColor = .white
        collectionView.register(cellType: PhotoCollectionViewCell.self)
        return collectionView
    }()
    
    enum Section {
        case bigSur
    }
    
    private let californiaImages = [
        CaliforniaImage(imageName: "image1"),
        CaliforniaImage(imageName: "image2"),
        CaliforniaImage(imageName: "image3"),
        CaliforniaImage(imageName: "image4"),
        CaliforniaImage(imageName: "image5"),
        CaliforniaImage(imageName: "image6"),
        CaliforniaImage(imageName: "image7"),
        CaliforniaImage(imageName: "image8")
    ]
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, CaliforniaImage>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        configureDataSource()
        createSnapshot(data: californiaImages)
    }
}

private extension CompositionalLayoutViewController {
    
    func configureUI() {

        configureCollectionView()
        makeConstraints()
    }
    
    func configureCollectionView() {
        
        view.addSubview(collectionView)
        
        collectionView.collectionViewLayout = generateLayout()
    }
    
    func makeConstraints() {
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

private extension CompositionalLayoutViewController {
    
    func generateLayout() -> UICollectionViewLayout {
        
        let spacing: CGFloat = 4
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        
        let photoItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(1/3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: photoItem,
                                                       count: 2)
        
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: spacing,
                                      leading: spacing,
                                      bottom: spacing,
                                      trailing: spacing)
        
        section.interGroupSpacing = spacing
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func configureDataSource(){
        
        dataSource = UICollectionViewDiffableDataSource<Section, CaliforniaImage>(collectionView: collectionView, cellProvider: { (collectionView, indexpath, model) -> UICollectionViewCell? in
            let cell: PhotoCollectionViewCell  = collectionView.dequeueReusableCell(for: indexpath)
            
            let cellModel = PhotoCollectionViewCellModel(image: model.imageName)
            
            cell.configureCell(with: cellModel)
            
            return cell
        })
    }
    
    func createSnapshot(data: [CaliforniaImage]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CaliforniaImage>()
        
        snapshot.appendSections([.bigSur])
        snapshot.appendItems(data)
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}
