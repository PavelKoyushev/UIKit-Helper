//
//  ImageTableViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 09.11.2023.
//

import UIKit

final class ImageTableViewCell: UITableViewCell, CodeCellConfigurable {
    
    private lazy var imgView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        configureUI()
    }
    
    func configureCell(with model: String) {
        
        imgView.image = UIImage(named: model)
    }
}

private extension ImageTableViewCell {
    
    func makeConstraints() {
        contentView.addSubview(imgView)
        
        imgView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width / 1.7)
        }
    }
    
    func configureUI() {
        
        imgView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
    }
}
