//
//  InputFieldState.swift
//  Toucheese
//
//  Created by 유지호 on 12/20/24.
//

import SwiftUI

enum InputFieldState {
    case empty
    case editing
    case error(message: String)
    
    var lineColor: Color {
        switch self {
        case .empty: .gray04
        case .editing: .primary06
        case .error: .red
        }
    }
    
    var description: String {
        switch self {
        case .error(let message): message
        default: ""
        }
    }
}
