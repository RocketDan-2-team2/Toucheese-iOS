//
//  View+Extension.swift
//  Toucheese
//
//  Created by 최주리 on 12/23/24.
//

import SwiftUI

extension View {
    
    func toucheeseButtonStyle(
        style: ToucheeseButtonStyle.ColorStyleType = .primaryColor,
        shapeStyle: ToucheeseButtonStyle.ShapeStyleType = .none,
        padding: (vertical: CGFloat?, horizontal: CGFloat?) = (14.0, 14.0)
    ) -> some View {
        modifier(
            ToucheeseButtonStyle(
                styleType: style,
                shapeStyleType: shapeStyle,
                padding: padding
            )
        )
    }
    
    func toucheeseAlert(
        alert: Binding<AlertType?>
    )
    -> some View {
        modifier(
            ToucheeseAlertModifier(alert: alert)
        )
    }
    
    func toucheeseToast(
        toast: Binding<ToastType?>
    )
    -> some View {
        modifier(
            ToucheeseToastModifier(toast: toast)
        )
    }
    
}
