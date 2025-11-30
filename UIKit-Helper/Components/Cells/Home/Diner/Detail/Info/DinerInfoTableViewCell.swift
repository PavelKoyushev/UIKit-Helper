//
//  DinerInfoTableViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 10.11.2023.
//

import UIKit

class DinerInfoTableViewCell: UITableViewCell, CellConfigurable {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }

    func configureCell(with model: String) {
        title.text = "Info"
        desc.text = model
    }
}

private extension DinerInfoTableViewCell {
    
    func configureUI() {
        
        contentView.do {
            $0.backgroundColor = .white
        }
        
        title.do {
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.textColor = .black
            $0.numberOfLines = 1
        }
        
        desc.do {
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = .black
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        }
    }
}
