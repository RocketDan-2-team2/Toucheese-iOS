//
//  RatingType.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import Foundation

enum RatingType: CaseIterable, FilterProtocol {
    case first
    case second
    case third
    
    var title: String {
        switch self {
        case .first: "3.0점 이상"
        case .second: "4.0점 이상"
        case .third: "4.5점 이상"
        }
    }
    
    var key: String {
        switch self {
        case .first: "ABOVE_3"
        case .second: "ABOVE_4"
        case .third: "ABOVE_4.5"
        }
    }
}
