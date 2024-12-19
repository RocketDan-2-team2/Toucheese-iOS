//
//  ReservationStateType.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import Foundation

enum ReservationStateType {
    case waiting
    case confirm
    case finished
    case cancel
    
    var title: String {
        switch self {
        case .waiting:
            "예약 대기"
        case .confirm:
            "예약 확정"
        case .finished:
            "촬영 완료"
        case .cancel:
            "예약 취소"
        }
    }
    
    var key: String {
        switch self {
        case .waiting:
            "KEEP_RESERVATION"
        case .confirm:
            "CONFIRM_RESERVATION"
        case .finished:
            "FINISHED_FILM"
        case .cancel:
            "CANCEL_RESERVATION"
        }
    }
}
