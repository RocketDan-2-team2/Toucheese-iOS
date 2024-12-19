//
//  ReservationStateTicket.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

struct ReservationStateTicket: View {
    
    let type: ReservationStateType
    var textColor: Color {
        switch type {
        case .waiting, .confirm:
                .gray07
        case .finished:
                .information
        case .cancel:
                .favorite
        }
    }
    var fillColor: Color {
        switch type {
        case .waiting, .finished, .cancel:
                .gray01
        case .confirm:
                .primary06
        }
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(fillColor)
            .stroke(type == .confirm ? .primary06 : .gray02)
            .frame(width: 60, height: 24)
            .overlay {
                Text("\(type.title)")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(textColor)
            }
    }
}

#Preview {
    ReservationStateTicket(type: .cancel)
}
