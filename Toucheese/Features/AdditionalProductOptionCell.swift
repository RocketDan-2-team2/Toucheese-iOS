//
//  AdditionalProductOptionCell.swift
//  Toucheese
//
//  Created by 유지호 on 11/27/24.
//

import SwiftUI

struct AdditionalProductOptionCell: View {
    let isGroupPhoto: Bool
    let name: String
    let price: Int
    
    @State private var isSelected: Bool = false {
        didSet {
            if !isSelected { count = 1 }
        }
    }
    
    @State private var count: Int = 1
    
    init(
        isGroupPhoto: Bool = false,
        name: String,
        price: Int,
        count: Int = 1
    ) {
        self.isGroupPhoto = isGroupPhoto
        self.name = name
        self.price = price
        self.count = count
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
            
            Text(name)
                .font(.title3)
                .bold()
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if isGroupPhoto {
                    HStack(spacing: 10) {
                        Button {
                            if count <= 1 { return }
                            count -= 1
                        } label: {
                            Image(systemName: "minus")
                                .frame(width: 20, height: 20)
                                .background(.placeholder)
                                .clipShape(.rect(cornerRadius: 6))
                                .opacity(count <= 1 ? 0.5 : 1)
                        }
                        .buttonStyle(.plain)
                        .disabled(count <= 1)
                        
                        Text(count.formatted() + "명")
                            .font(.headline)
                        
                        Button {
                            if count >= 100 { return }
                            count += 1
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 20, height: 20)
                                .background(.placeholder)
                                .clipShape(.rect(cornerRadius: 6))
                                .opacity(count >= 100 ? 0.5 : 1)
                        }
                        .buttonStyle(.plain)
                        .disabled(count >= 100)
                    }
                }
                
                Text((price * count).formatted() + "원")
                    .font(.title3)
                    .bold()
            }
        }
    }
}

#Preview {
    AdditionalProductOptionCell(
        isGroupPhoto: true,
        name: "보정 사진 추가",
        price: 75000
    )
}
