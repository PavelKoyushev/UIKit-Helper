//
//  MainViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 17.04.2022.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    private var oneButton = BlueButton()
    
    private var twoButton = BlueButton()
    
    private var threeButton = BlueButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
    }
}

private extension MainViewController {
    
    func configureUI() {
        
        configureButtons()
        makeConstraints()
    }
    
    func configureButtons() {
        
        oneButton.setTitle("Diffable Data Source", for: .normal)
        oneButton.addTarget(self, action: #selector(routeToDDSView), for: .touchUpInside)
        
        twoButton.setTitle("CollectionView Compositional Layout", for: .normal)
        twoButton.addTarget(self, action: #selector(routeToPhotoCollectionView), for: .touchUpInside)
        
        threeButton.setTitle("UIKit", for: .normal)
        threeButton.addTarget(self, action: #selector(routeToUIKitViewController), for: .touchUpInside)
        
        view.addSubview(oneButton)
        view.addSubview(twoButton)
        view.addSubview(threeButton)
    }
    
    func makeConstraints() {
        
        oneButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(40)
            $0.horizontalEdges.equalToSuperview().inset(45)
        }
        
        twoButton.snp.makeConstraints {
            $0.top.equalTo(oneButton.snp.bottom).offset(20)
            $0.height.equalTo(40)
            $0.horizontalEdges.equalToSuperview().inset(45)
        }
        
        threeButton.snp.makeConstraints {
            $0.top.equalTo(twoButton.snp.bottom).offset(20)
            $0.height.equalTo(40)
            $0.horizontalEdges.equalToSuperview().inset(45)
        }
    }
}

private extension MainViewController {
    
    @objc func routeToDDSView() {
        
        let viewController = ExampleDDSViewController()
        
        present(viewController, animated: true)
    }
    
    @objc func routeToPhotoCollectionView() {
        
        let viewController = CompositionalLayoutViewController()
        
        present(viewController, animated: true)
    }
    
    @objc func routeToUIKitViewController() {
        
        let viewController = UIKitViewController()
        
        present(viewController, animated: true)
    }
}
