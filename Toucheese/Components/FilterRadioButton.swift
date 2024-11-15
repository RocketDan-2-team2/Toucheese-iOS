//
//  FilterRadioButton.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import SwiftUI

struct FilterRadioButton<T: FilterProtocol & Equatable>: View {
    
    let type: T?
    @Binding var selectedType: T?
    
//    let filterName: String
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
            VStack(alignment: .center) {
                if let type {
                    Text("\(type.title)")
                } else {
                    Text("전체")
                }
                    
                Image(systemName: isSelected ? "circle.fill" : "circle")
            }
            .font(.system(size: 14))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
