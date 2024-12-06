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
            HStack(alignment: .center) {
                Image(systemName: isSelected ? "circle.fill" : "circle")
                
                Text(type.title)
            }
            .font(.system(size: 14))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
