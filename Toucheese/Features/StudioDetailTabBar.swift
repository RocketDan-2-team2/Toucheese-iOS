//
//  StudioDetailTab.swift
//  Toucheese
//
//  Created by SunJoon Lee on 11/28/24.
//

import SwiftUI

struct StudioDetailTabBar: View {
    
    @Binding var tabSelection: StudioDetailTabType
    @Namespace private var tabAnimation
    
    var body: some View {
        HStack(spacing: 0.0) {
            ForEach(StudioDetailTabType.allCases, id: \.self) { tabType in
                TabItem(
                    tabType: tabType,
                    hasSelected: tabSelection == tabType,
                    namespace: tabAnimation
                )
                .onTapGesture {
                    tabSelection = tabType
                }
            }
        }
        .animation(.interactiveSpring(duration: 0.5), value: tabSelection)
    }
    
    private struct TabItem: View {
        
        let tabType: StudioDetailTabType
        let hasSelected: Bool
        var namespace: Namespace.ID
        
        private var customFontColor: Color {
            let selectedColor = Color(red: 31 / 255, green: 31 / 255, blue: 31 / 255)
            let unselectedColor = Color(red: 89 / 255, green: 89 / 255, blue: 89 / 255)
            
            return hasSelected ? selectedColor : unselectedColor
        }
        
        let selectedBackground = Color(red: 255 / 255, green: 192 / 255, blue: 0 / 255)
        
        var body: some View {
            HStack {
                Spacer()
                Text(tabType.toString)
                    .foregroundStyle(customFontColor)
                Spacer()
            }
            .contentShape(.rect)
            .padding(8.0)
            .background {
                if hasSelected {
                    RoundedRectangle(cornerRadius: 12.0)
                        .fill(selectedBackground)
                        .matchedGeometryEffect(id: "ActiveTab", in: namespace)
                }
            }
        }
    }
}

#Preview {
    StudioDetailView(studioId: 0)
}
