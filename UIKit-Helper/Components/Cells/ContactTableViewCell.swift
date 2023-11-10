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

final class ContactTableViewCell: UITableViewCell, CodeCellConfigurable {
    
    private lazy var nameLabel = UILabel()
    private lazy var gradeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
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
    
    func makeConstraints() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(gradeLabel)
        
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
