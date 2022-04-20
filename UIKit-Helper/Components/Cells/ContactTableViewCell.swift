//
//  ContactTableViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 18.04.2022.
//

import UIKit

struct ContactTableViewCellModel {
    
    let name: String
    let grade: String
}

class ContactTableViewCell: UITableViewCell, CodeCellConfigurable {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let gradeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        gradeLabel.text = nil
    }
    
    func configureCell(with model: ContactTableViewCellModel) {
        
        nameLabel.text = model.name
        gradeLabel.text = model.grade
    }
}

private extension ContactTableViewCell {
    
    private func configureUI() {
        
        configureLabels()
        makeConstraints()
    }
    
    private func configureLabels() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(gradeLabel)
    }
    
    private func makeConstraints() {
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(12)
        }
        
        gradeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
    
}

#if DEBUG

import SwiftUI

struct ContactTableViewCellPreview: UIViewRepresentable {
    let viewBuilder: () -> UITableViewCell

    init(_ viewBuilder: @escaping () -> UITableViewCell) {
        self.viewBuilder = viewBuilder
    }

    func makeUIView(context: Context) -> some UITableViewCell {
        viewBuilder()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Not needed
    }
}

struct ContactTableViewCell_Preview: PreviewProvider {

    static var previews: some View {

        ContactTableViewCellPreview {

            ContactTableViewCell(frame: .zero)
        }
    }
}
#endif
