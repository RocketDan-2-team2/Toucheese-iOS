//
//  ToastType.swift
//  Toucheese
//
//  Created by 최주리 on 12/23/24.
//

import Foundation

enum ToastType: Hashable {
    case cancelSuccess(date: String)
    case cancelFail
    
    case orderFail
    case reservationUpdateFail
    
}
