//
//  AdditionalProductOptionCell.swift
//  Toucheese
//
//  Created by 유지호 on 11/27/24.
//

import SwiftUI

struct AdditionalProductOptionCell: View {
    let isGroupPhoto: Bool
    
    @State private var isSelected: Bool = false
    
    @Binding private var option: StudioProductOption {
        didSet {
            isSelected = option.count > 0
        }
    }
    
    var totalPrice: Int {
        option.count < 1 ? option.price : option.price * option.count
    }
    
    init(
        isGroupPhoto: Bool = false,
        option: Binding<StudioProductOption>
    ) {
        self.isGroupPhoto = isGroupPhoto
        self._option = option
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Button {
                if isSelected {
                    option.count = 0
                    isSelected = false
                } else {
                    option.count = max(option.count, 1)
                    isSelected = true
                }
            } label: {
                Rectangle()
                    .fill(
                        .shadow(.inner(
                            color: .black.opacity(0.3),
                            radius: 2,
                            y: 4))
                    )
                    .foregroundStyle(.yellow)
                    .frame(width: 20, height: 20)
                    .overlay {
                        if isSelected {
                            Image(systemName: "checkmark")
                        }
                    }
            }
            .buttonStyle(.plain)
            
            Text(option.name)
                .fontWeight(.medium)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if isGroupPhoto {
                    HStack(spacing: 10) {
                        Button {
                            if option.count <= 0 { return }
                            option.count -= 1
                        } label: {
                            Image(systemName: "minus")
                                .frame(width: 20, height: 20)
                                .background(.placeholder)
                                .clipShape(.rect(cornerRadius: 6))
                                .opacity(option.count <= 0 ? 0.5 : 1)
                        }
                        .buttonStyle(.plain)
                        .disabled(option.count <= 0)
                        
                        Text(option.count.formatted() + "명")
                            .font(.headline)
                        
                        Button {
                            if option.count >= 100 { return }
                            isSelected = true
                            option.count += 1
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 20, height: 20)
                                .background(.placeholder)
                                .clipShape(.rect(cornerRadius: 6))
                                .opacity(option.count >= 100 ? 0.5 : 1)
                        }
                        .buttonStyle(.plain)
                        .disabled(option.count >= 100)
                    }
                }
                
                Text(totalPrice.formatted() + "원")
                    .bold()
            }
        }
    }
}

#Preview {
    AdditionalProductOptionCell(
        isGroupPhoto: true,
        option: .constant(.init(
            id: 0,
            name: "보정 사진 추가",
            description: "설명",
            price: 30000,
            count: 0
        ))
    )
}
