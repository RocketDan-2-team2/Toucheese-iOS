//
//  StudioDetailTabType.swift
//  Toucheese
//
//  Created by SunJoon Lee on 12/10/24.
//

import Foundation

enum StudioDetailTabType: CaseIterable {
    case price
    case review
    
    var toString: String {
        switch self {
        case .price:
            "가격"
        case .review:
            "리뷰"
        }
    }
}
