//
//  FilterType.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import Foundation

enum FilterType: CaseIterable {
    
    case region
    case rating
    case price
    
    var title: String {
        switch self {
        case .region: "지역"
        case .rating: "평점"
        case .price: "가격"
        }
    }
    
}
