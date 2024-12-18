//
//  CommonButton.swift
//  Toucheese
//
//  Created by SunJoon Lee on 12/16/24.
//

import SwiftUI

struct ToucheeseButtonStyle: ViewModifier {
    let styleType: StyleType
    let shapeStyleType: ShapeStyleType
    let padding: (vertical: CGFloat?, horizontal: CGFloat?)
    
    private var background: Color {
        switch styleType {
        case .light: Color.gray01
        case .medium: Color.gray02
        case .color: Color.primary06
        case .withColor(let color): color
        }
    }
    
    private var ratio: CGFloat? {
        switch shapeStyleType {
        case .none: nil
        case .square: 1.0
        case .ratio(let cgFloat): cgFloat
        case .fullWidth: nil
        }
    }
    
    func body(
        content: Content
    ) -> some View {
        HStack {
            if shapeStyleType != .none {
                Spacer()
            }
            content
            if shapeStyleType != .none {
                Spacer()
            }
        }
        .padding(.vertical, self.padding.vertical)
        .padding(.horizontal, self.padding.horizontal)
        .background {
            if shapeStyleType == .none || shapeStyleType == .fullWidth {
                RoundedRectangle(cornerRadius: 8.0)
                    .fill(background)
            } else {
                RoundedRectangle(cornerRadius: 8.0)
                    .fill(background)
                    .aspectRatio(ratio, contentMode: .fit)
            }
        }
    }
    
    enum StyleType: Equatable {
        /// gray01 - FAFAFA
        case light
        /// gray02 - F5F5F5
        case medium
        /// primary06 - FFC000
        case color
        /// 연관값으로 주어진 컬러
        case withColor(color: Color)
    }
    
    enum ShapeStyleType: Equatable {
        case none
        case square
        case ratio(CGFloat?)
        case fullWidth
    }
}

extension View {
    func toucheeseButtonStyle(
        style: ToucheeseButtonStyle.StyleType = .color,
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
}

#Preview {
    Text("Hello World")
        .toucheeseButtonStyle()
}
