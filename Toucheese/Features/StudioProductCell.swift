//
//  StudioProductCell.swift
//  Toucheese
//
//  Created by 유지호 on 11/26/24.
//

import SwiftUI

struct StudioProductCell: View {
    let product: StudioProduct
    
    init(product: StudioProduct) {
        self.product = product
    }
    
    var body: some View {
        HStack(spacing: 8) {
            AsyncImage(url: URL(string: product.image ?? "")) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 140)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.placeholder)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(product.name)
                    .bold()
                    .font(.title3)
                
                Text(product.description)
                    .font(.system(size: 14))
                
                HStack {
                    Text("리뷰 \(product.reviewCount.formatted())개")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    Text(product.price.formatted() + "원")
                        .bold()
                        .font(.title3)
                }
            }
            .padding(.vertical, 4)
        }
        .frame(height: 140)
        .padding(.horizontal, 12)
        .contentShape(.rect)
    }
}

#Preview {
    StudioProductCell(product: .init(
        id: 0,
        image: nil,
        name: "상품 이름",
        description: "상품 소개\n상품 소개\n상품 소개",
        reviewCount: 1234,
        price: 123456,
        optionList: []
    ))
}
