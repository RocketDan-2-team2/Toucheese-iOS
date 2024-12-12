//
//  PaymentRadioButton.swift
//  Toucheese
//
//  Created by 최주리 on 12/6/24.
//

import SwiftUI

struct PaymentRadioButton: View {
    
    let type: PaymentType
    @Binding var selectedType: PaymentType
    
    let tapAction: (() -> Void)?
    
    var isSelected: Bool {
        selectedType == type
    }
    
    
    init(
        type: PaymentType = .pg,
        selectedType: Binding<PaymentType>,
        tapAction: (() -> Void)? = nil
        
    ) {
        self.type = type
        self._selectedType = selectedType
        self.tapAction = tapAction
    }
    
    var body: some View {
        Button {
            selectedType = type
            tapAction?()
        } label: {
            HStack(alignment: .center, spacing: 8) {
                Circle()
                    .strokeBorder(isSelected ? .primary06 : .gray04, lineWidth: isSelected ? 4 : 1)
                    .frame(width: 16, height: 16)
                
                Text(type.title)
                    .font(.system(size: 16))
                    .foregroundStyle(.gray07)
                    .fontWeight(isSelected ? .bold : .medium)
            }
            .font(.system(size: 14))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
