//
//  MembershipStatusTableViewCell.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 22.02.2024.
//

import UIKit
import RxSwift
import Reusable
import RxRelay

final class MembershipStatusTableViewCell: UITableViewCell, CodeCellConfigurable {
    
    private lazy var progress = UIProgressView()
    
    private lazy var status = UILabel()
    private lazy var nextStatus = UILabel()
    private lazy var points = UILabel()
    
    private lazy var min = UILabel()
    private lazy var max = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    func configureCell(with model: MembershipStatusProtocol) {
        status.text = model.status
        nextStatus.text = model.nextStatus
        points.text = "Your points: \(model.points)"
        
        min.text = String(model.min)
        max.text = String(model.max)
        
        let value = Float(model.points) / Float(model.max)
        progress.setProgress(value, animated: false)
    }
}

extension MembershipStatusTableViewCell {
    
    func makeConstraints() {
        contentView.addSubview(status)
        contentView.addSubview(nextStatus)
        contentView.addSubview(points)
        contentView.addSubview(progress)
        contentView.addSubview(min)
        contentView.addSubview(max)
        
        status.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        
        nextStatus.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalTo(status.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        points.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(status.snp.bottom).offset(1)
        }
        
        progress.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(14)
            $0.top.equalTo(points.snp.bottom).offset(8)
        }
        
        min.snp.makeConstraints {
            $0.top.equalTo(progress.snp.bottom).offset(8)
            $0.leading.equalTo(progress.snp.leading)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        max.snp.makeConstraints {
            $0.top.equalTo(progress.snp.bottom).offset(8)
            $0.trailing.equalTo(progress.snp.trailing)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
    func configureUI() {
        
        let margins = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
        contentView.frame = contentView.frame.inset(by: margins)
        
        contentView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 16
            $0.layer.shadowColor = UIColor.darkGray.cgColor
            $0.layer.shadowRadius = 4
            $0.layer.shadowOpacity = 0.3
            $0.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        }
        
        status.do {
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.textColor = .black
        }
        
        points.do {
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = .black
        }
        
        nextStatus.do {
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = .black
            $0.textAlignment = .left
        }
        
        min.do {
            $0.font = .systemFont(ofSize: 12, weight: .medium)
            $0.textColor = .black
        }
        
        max.do {
            $0.font = .systemFont(ofSize: 12, weight: .medium)
            $0.textColor = .black
        }
    }
}
