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
        
        view.addSubview(oneButton)
    }
    
    func makeConstraints() {
        
        oneButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(40)
            $0.horizontalEdges.equalToSuperview().inset(45)
        }
    }
    
    @objc func routeToDDSView() {
        
        let viewController = ExampleDDSViewController()
        
        present(viewController, animated: true)
    }
}
