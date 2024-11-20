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
    case fourth
    case fifth
    case sixth
    case seventh
    case eighth
    case ninth
    
    var title: String {
        switch self {
        case .first:
            return "강남"
        case .second:
            return "서초"
        case .third:
            return "송파"
        case .fourth:
            return "강서"
        case .fifth:
            return "마포"
        case .sixth:
            return "영등포"
        case .seventh:
            return "강북"
        case .eighth:
            return "용산"
        case .ninth:
            return "성동"
        }
    }
}
