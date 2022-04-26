//
//  MainViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 17.04.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var oneButton = BlueButton()
    
    var twoButton = BlueButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
    }
}

extension MainViewController {
    
    func configureUI() {
        
        configureButtons()
        makeConstraints()
    }
    
    func configureButtons() {
        
        oneButton.setTitle("Diffable Data Source", for: .normal)
        oneButton.addTarget(self, action: #selector(routeToDDSView), for: .touchUpInside)
        
        twoButton.setTitle("CollectionView Compositional Layout", for: .normal)
        
        view.addSubview(oneButton)
        view.addSubview(twoButton)
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
    }
    
    @objc func routeToDDSView() {
        
        let viewController = ExampleDDSViewController()
        
        present(viewController, animated: true)
    }
}
