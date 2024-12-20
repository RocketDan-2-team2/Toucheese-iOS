//
//  FilterRadioButton.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import SwiftUI

struct FilterRadioButton<T: FilterProtocol>: View {
    
    let type: T?
    @Binding var selectedType: T?
    
    let filterAction: (() -> Void)?
    
    var isSelected: Bool {
        selectedType == type
    }
    
    
    init(
        type: T? = nil,
        selectedType: Binding<T?>,
        filterAction: (() -> Void)? = nil
        
    ) {
        self.type = type
        self._selectedType = selectedType
        self.filterAction = filterAction
    }
    
    var body: some View {
        Button {
            selectedType = type
            filterAction?()
        } label: {
            HStack {
                selectionButton(isSelected: self.isSelected)
                    .frame(width: 18.0, height: 18.0)
                
                if let type {
                    Text(type.title)
                        .bold(isSelected)
                } else {
                    Text("전체")
                        .bold(isSelected)
                }
            }
            .font(.system(size: 14.0))
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    func selectionButton(isSelected: Bool) -> some View {
        if isSelected {
            ZStack {
                Circle()
                    .fill(Color.primary06)
                Circle()
                    .fill(.background)
                    .frame(width: 8.0, height: 8.0)
            }
        } else {
            Circle()
                .strokeBorder(Color.gray04, lineWidth: 1.0)
        }
    }
}

#Preview {
    FilterRadioButton(selectedType: .constant(PriceType.first))
    FilterRadioButton(type: PriceType.first, selectedType: .constant(.first))
    FilterRadioButton(type: PriceType.second, selectedType: .constant(.first))
    FilterRadioButton(type: PriceType.third, selectedType: .constant(.first))
}
