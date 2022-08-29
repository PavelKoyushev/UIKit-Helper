//
//  UIKitViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 29.08.2022.
//

import UIKit

final class UIKitViewController: UIViewController {
    
    var textField = MainTextField()
    var textEditor = MainTextView(frame: .zero)
    var slider = AppSlider()
    
    var label: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        setupViews()
    }
}

private extension UIKitViewController {
    
    func configureUI() {
        
        configureViews()
        makeConstraints()
    }
    
    func configureViews() {
        
        view.addSubview(textField)
        view.addSubview(textEditor)
        view.addSubview(label)
        view.addSubview(slider)
    }
    
    func makeConstraints() {
        
        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.height.equalTo(40)
            $0.horizontalEdges.equalToSuperview().inset(45)
        }
        
        textEditor.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(20)
            $0.height.equalTo(100)
            $0.horizontalEdges.equalToSuperview().inset(45)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(textEditor.snp.bottom).offset(20)
            $0.height.equalTo(20)
            $0.horizontalEdges.equalToSuperview().inset(45)
        }
        
        slider.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.height.equalTo(20)
            $0.horizontalEdges.equalToSuperview().inset(45)
        }
    }
}

private extension UIKitViewController {
    
    func setupViews() {
        setupView()
        setupSlider()
    }
    
    func setupView() {
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setupSlider() {
        
        label.text = String(Int(slider.value))
        slider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
    }
}

private extension UIKitViewController {
    
    @objc func sliderValueDidChange(_ sender: UISlider!) {
        label.text = String(Int(sender.value))
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
        textEditor.resignFirstResponder()
    }
}
