//
//  StudioDetailTab.swift
//  Toucheese
//
//  Created by SunJoon Lee on 11/28/24.
//

import SwiftUI

struct StudioDetailTab: View {
    @State private var tabSelection: Int = 0
    
    var body: some View {
        VStack {
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
        }
    }
    
    private struct TabButton: View {
        let title: String
        let isSelected: Bool
        
        var body: some View {
            HStack {
                Spacer()
                Text(title)
                Spacer()
            }
            .padding(10.0)
            .background(
                UnevenRoundedRectangle(
                    topLeadingRadius: 20.0,
                    topTrailingRadius: 20.0
                )
                .fill(isSelected ? .orange : .yellow)
            )
        }
    }
}

#Preview {
    StudioDetailTab()
}
