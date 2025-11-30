//
//  UIKitViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 29.08.2022.
//

import UIKit

final class UIKitViewController: UIViewController {
    
    private let textField = MainTextField()
    private let textEditor = MainTextView(frame: .zero)
    private let slider = AppSlider()
    private let label = UILabel()
    private let animatedButton = AnimatedButton()
    
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
        
        label.textColor = .blue
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
    }
    
    func makeConstraints() {
        view.addSubview(textField)
        view.addSubview(textEditor)
        view.addSubview(label)
        view.addSubview(slider)
        view.addSubview(animatedButton)
        
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
        
        animatedButton.snp.makeConstraints {
            $0.top.equalTo(slider.snp.bottom).offset(30)
            $0.height.equalTo(50)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
    }
}

private extension UIKitViewController {
    
    func setupViews() {
        setupView()
        setupSlider()
        setupButton()
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
    
    func setupButton() {
        animatedButton.setTitle("Continue")
        animatedButton.onButtonTap = {
            print("Continue tapped!")
        }
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
