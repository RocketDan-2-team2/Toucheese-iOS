//
//  RatingType.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import Foundation

enum RatingType: CaseIterable {
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
}
