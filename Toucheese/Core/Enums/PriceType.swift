//
//  PriceType.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import Foundation

enum PriceType: CaseIterable, FilterProtocol {
    
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
    
    var key: String {
        switch self {
        case .first: "BELOW_10"
        case .second: "BELOW_20"
        case .third: "ABOVE_20"
        }
    }
}
