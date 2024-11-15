//
//  RegionType.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import Foundation

enum RegionType: CaseIterable, FilterProtocol {
    
    case first
    case second
    case third
    
    var title: String {
        switch self {
        case .first: "강남/서초/송파"
        case .second: "강서/마포/영등포"
        case .third: "강북/용산/성동"
        }
    }
}
