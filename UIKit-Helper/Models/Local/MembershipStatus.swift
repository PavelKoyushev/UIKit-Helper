//
//  MembershipStatus.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 23.02.2024.
//

import Foundation

protocol MembershipStatusProtocol {
    var status: String { get set }
    var nextStatus: String { get set }
    var points: Int { get set }
    var min: Int { get set }
    var max: Int { get set }
}

struct MembershipStatus: MembershipStatusProtocol {
    var status: String // Newbie, Experienced, Master, Legend
    var nextStatus: String
    var points: Int
    var min: Int
    var max: Int
}

extension MembershipStatus {
    
    static var mock: Self {
        MembershipStatus(status: "Newbie",
                         nextStatus: "Experienced",
                         points: 700,
                         min: 0,
                         max: 1000)
    }
}
