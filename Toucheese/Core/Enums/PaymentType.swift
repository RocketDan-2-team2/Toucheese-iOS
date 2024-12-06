//
//  PaymentType.swift
//  Toucheese
//
//  Created by 최주리 on 12/6/24.
//

import Foundation

enum PaymentType: CaseIterable {
    case PG
    case kakao
    case toss
    
    var title: String {
        switch self {
        case .PG: "신용/체크카드"
        case .kakao: "카카오페이"
        case .toss: "토스페이"
        }
    }
}
