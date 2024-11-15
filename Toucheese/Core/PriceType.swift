//
//  PriceType.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import Foundation

enum PriceType: CaseIterable {
    case first
    case second
    case third
    
    var title: String {
        switch self {
        case .first: "10만원 이하"
        case .second: "20만원 이하"
        case .third: "20만원 이상"
        }
    }
}
