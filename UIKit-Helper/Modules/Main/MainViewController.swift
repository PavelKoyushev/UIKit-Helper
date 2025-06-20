//
//  MainViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 17.04.2022.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private let goodsButton = BlueButton()
    private let oneButton = BlueButton()
    private let twoButton = BlueButton()
    private let threeButton = BlueButton()
    private let fourButton = BlueButton()
    
    let goodsService = GoodsService(
        fileProvider: BundleFileProvider(),
        decoder: JSONDecoderService(),
        mapper: GoodsMapper()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
}

private extension MainViewController {
    
    func configureUI() {
        configureButtons()
        setupUI()
        makeConstraints()
    }
    
    func configureButtons() {
        goodsButton.setTitle("Products view", for: .normal)
        goodsButton.addTarget(self, action: #selector(routeToProductsView), for: .touchUpInside)
        
        oneButton.setTitle("Diffable Data Source", for: .normal)
        oneButton.addTarget(self, action: #selector(routeToDDSView), for: .touchUpInside)
        
        twoButton.setTitle("CollectionView Compositional Layout", for: .normal)
        twoButton.addTarget(self, action: #selector(routeToPhotoCollectionView), for: .touchUpInside)
        
        threeButton.setTitle("UIKit", for: .normal)
        threeButton.addTarget(self, action: #selector(routeToUIKitViewController), for: .touchUpInside)
        
        fourButton.setTitle("UICollectionViewFlowLayout", for: .normal)
        fourButton.addTarget(self, action: #selector(routeToCVFLViewController), for: .touchUpInside)
    }
    
    func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        [goodsButton, oneButton, twoButton, threeButton, fourButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(40)
            }
            stackView.addArrangedSubview($0)
        }
    }
    
    func makeConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
            $0.width.equalToSuperview().inset(20)
        }
    }
}

private extension MainViewController {
    
    @objc func routeToProductsView() {
        
        let viewController = GoodsViewController()
        let viewModel = GoodsViewModel(goodsService: goodsService)
        
        viewController.inject(viewModel: viewModel)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func routeToDDSView() {
        
        let viewController = ExampleDDSViewController()
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func routeToPhotoCollectionView() {
        
        let viewController = CompositionalLayoutViewController()
        
        present(viewController, animated: true)
    }
    
    @objc func routeToUIKitViewController() {
        
        let viewController = UIKitViewController()
        
        present(viewController, animated: true)
    }
    
    @objc func routeToCVFLViewController() {
        
        let viewController = CVFLViewController()
        
        present(viewController, animated: true)
    }
}
