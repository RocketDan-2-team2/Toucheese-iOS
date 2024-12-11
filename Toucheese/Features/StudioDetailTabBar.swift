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
    let backgroundColor = Color(red: 0.9608, green: 0.9608, blue: 0.9608)
    
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
//        .padding(8.0)
//        .background {
//            RoundedRectangle(cornerRadius: 16.0)
//                .fill(backgroundColor)
//        }
//        .padding(8.0)
        .animation(.interactiveSpring(duration: 0.5), value: tabSelection)
    }
    
    private struct TabItem: View {
        
        let tabType: StudioDetailTabType
        let hasSelected: Bool
        var namespace: Namespace.ID
        
        private var customFontColor: Color {
            let selectedColor = Color(red: 0.1216, green: 0.1216, blue: 0.1216)
            let unselectedColor = Color(red: 0.349, green: 0.349, blue: 0.349)
            
            return hasSelected ? selectedColor : unselectedColor
        }
        
        let selectedBackground = Color(red: 1.0, green: 0.7529, blue: 0.0)
        
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
//    StudioDetailTab(tabSelection: .constant(.price))
    StudioDetailView(studioId: 0)
}
