//
//  FreeTrialModel.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 15.07.2025.
//

import Foundation

struct FreeTrialModel {
    
    let title: String
    let subTitle: String
}

extension FreeTrialModel {
    
    static var mock: Self {
        FreeTrialModel(title: "Try three days free trial",
                       subTitle: "You will get all premium templates, additional stickers and no ads")
    }
}
