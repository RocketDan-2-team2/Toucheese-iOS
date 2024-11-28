//
//  AdditionalProductOptionCell.swift
//  Toucheese
//
//  Created by 유지호 on 11/27/24.
//

import SwiftUI

struct AdditionalProductOptionCell: View {
    let isGroupPhoto: Bool
    
    @State private var isSelected: Bool = false {
        didSet {
            if !isSelected { option.count = 1 }
        }
    }
    
    @State private var option: StudioProductOption
    
    init(
        isGroupPhoto: Bool = false,
        option: StudioProductOption,
        count: Int = 1
    ) {
        self.isGroupPhoto = isGroupPhoto
        self.option = option
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Button {
                isSelected.toggle()
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
            .padding(.top, 3)
            
            Text(option.name)
                .font(.title3)
                .bold()
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if isGroupPhoto {
                    HStack(spacing: 10) {
                        Button {
                            if option.count <= 1 { return }
                            option.count -= 1
                        } label: {
                            Image(systemName: "minus")
                                .frame(width: 20, height: 20)
                                .background(.placeholder)
                                .clipShape(.rect(cornerRadius: 6))
                                .opacity(option.count <= 1 ? 0.5 : 1)
                        }
                        .buttonStyle(.plain)
                        .disabled(option.count <= 1)
                        
                        Text(option.count.formatted() + "명")
                            .font(.headline)
                        
                        Button {
                            if option.count >= 100 { return }
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
                
                Text((option.price * option.count).formatted() + "원")
                    .font(.title3)
                    .bold()
            }
        }
    }
}

#Preview {
    AdditionalProductOptionCell(
        isGroupPhoto: true,
        option: .init(
            id: 0,
            name: "보정 사진 추가",
            description: "설명",
            price: 30000,
            count: 1
        )
    )
}
