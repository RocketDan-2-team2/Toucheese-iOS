//
//  FilterButton.swift
//  Toucheese
//
//  Created by 최주리 on 11/14/24.
//

import SwiftUI

struct FilterButton: View {
    // 임시
    var isSelected: Bool = false
    
    let filterName: String
    let filterAction: (() -> Void)?
    
    init(
        filterName: String,
        isSelected: Bool = false,
        filterAction: (() -> Void)? = nil
    ) {
        self.filterName = filterName
        self.isSelected = isSelected
        self.filterAction = filterAction

    }
    
    var body: some View {
        Button {
            filterAction?()
        } label: {
            HStack {
                Text("\(filterName)")
                Image(systemName: "chevron.down")
                    .font(.system(size: 12))
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(isSelected ? .orange.opacity(0.7) : .orange.opacity(0.2))
            .clipShape(.rect(cornerRadius: 20))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    FilterButton(filterName: "지역", isSelected: true)
}
