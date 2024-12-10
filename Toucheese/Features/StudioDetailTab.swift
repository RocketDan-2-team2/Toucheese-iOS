//
//  StudioDetailTab.swift
//  Toucheese
//
//  Created by SunJoon Lee on 11/28/24.
//

import SwiftUI

struct StudioDetailTab: View {
    @Binding var tabSelection: Int
    
    let backgroundColor = Color(red: 0.9608, green: 0.9608, blue: 0.9608)
    
    var body: some View {
        HStack(spacing: 0.0) {
            TabButton(title: "가격", isSelected: tabSelection == 0)
                .onTapGesture {
                    tabSelection = 0
                }
            TabButton(title: "리뷰", isSelected: tabSelection == 1)
                .onTapGesture {
                    tabSelection = 1
                }
        }
        .padding(8.0)
        .background {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(backgroundColor)
        }
    }
    
    private struct TabButton: View {
        let title: String
        let isSelected: Bool
        
        private var customFontColor: Color {
            let selectedColor = Color(red: 0.1216, green: 0.1216, blue: 0.1216)
            let unselectedColor = Color(red: 0.349, green: 0.349, blue: 0.349)
            
            return isSelected ? selectedColor : unselectedColor
        }
        
        private var backgroundColor: Color {
            let selectedColor = Color(red: 1.0, green: 0.7529, blue: 0.0)
            let unselectedColor = Color.clear
            
            return isSelected ? selectedColor : unselectedColor
        }
        
        var body: some View {
            HStack {
                Spacer()
                Text(title)
                    .foregroundStyle(customFontColor)
                Spacer()
            }
            .padding(8.0)
            .background {
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(backgroundColor)
            }
        }
    }
}

#Preview {
    StudioDetailTab(tabSelection: .constant(0))
}
