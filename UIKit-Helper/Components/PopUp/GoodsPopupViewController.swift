//
//  GoodsPopupViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 19.06.2025.
//

import UIKit

final class GoodsPopupViewController: UIViewController {
    
    private let containerView = UIView()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceView: PriceView = {
        let view = PriceView()
        return view
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceStack: UIStackView = {
        let spacer = UIView()
        let stack = UIStackView(arrangedSubviews: [spacer, priceView])
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, priceStack, descLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        return stack
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addGestures()
    }
    
    func configure(with model: Goods) {
        nameLabel.text = model.name
        priceView.configure(with: model.price,
                            isBold: true)
        descLabel.text = model.description
    }
}

private extension GoodsPopupViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        
        view.addSubview(containerView)
        containerView.addSubview(verticalStack)
        
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 64)
        }
        
        verticalStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    func addGestures() {
        addGesture()
        addPanGesture()
    }
    
    func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(handleBackgroundTap))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    func addPanGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                          action: #selector(handlePan))
        containerView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .changed:
            if translation.y > 0 {
                containerView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended, .cancelled:
            let shouldDismiss = translation.y > 100
            if shouldDismiss {
                dismiss(animated: true)
            } else {
                UIView.animate(withDuration: 0.25) {
                    self.containerView.transform = .identity
                }
            }
        default:
            break
        }
    }
    
    @objc func handleBackgroundTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        if !containerView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }
}
