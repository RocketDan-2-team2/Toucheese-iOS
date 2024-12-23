//
//  View+Extension.swift
//  Toucheese
//
//  Created by 최주리 on 12/23/24.
//

import SwiftUI

extension View {
    func toucheeseAlert(
        alert: Binding<AlertType?>
    )
    -> some View {
        modifier(
            ToucheeseAlertModifier(alert: alert)
        )
    }
}
