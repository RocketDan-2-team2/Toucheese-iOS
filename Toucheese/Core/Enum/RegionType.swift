//
//  RegionType.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import Foundation

enum RegionType: FilterProtocol {
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
        case .first: "강남"
        case .second: "서초"
        case .third: "송파"
        case .fourth: "강서"
        case .fifth: "마포"
        case .sixth: "영등포"
        case .seventh: "강북"
        case .eighth: "용산"
        case .ninth: "성동"
        }
    }
    
    var key: String {
        switch self {
        case .first: "GANGNAM"
        case .second: "SEOCHO"
        case .third: "SONGPA"
        case .fourth: "GANGSEO"
        case .fifth: "MAPO"
        case .sixth: "YEONGDEUNGPO"
        case .seventh: "GANGBUK"
        case .eighth: "YONGSAN"
        case .ninth: "SEONGDONG"
        }
    }
}
