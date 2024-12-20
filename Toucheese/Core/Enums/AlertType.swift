//
//  AlertType.swift
//  Toucheese
//
//  Created by 최주리 on 12/19/24.
//

import Foundation

enum AlertType: Identifiable {
    case dateChanged(date: String)
    case reservationCancel(action: () -> Void)
    
    var id: String {
        "\(self)"
    }
}
