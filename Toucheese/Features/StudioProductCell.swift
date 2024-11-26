//
//  StudioProductCell.swift
//  Toucheese
//
//  Created by 유지호 on 11/26/24.
//

import SwiftUI

struct StudioProductCell: View {
    let name: String
    let introduction: String
    let reviewCount: Int
    let price: Int
    
    init(
        name: String = "상품 이름",
        introduction: String = "상품 소개\n상품 소개\n상품 소개",
        reviewCount: Int = 1234,
        price: Int = 123456
    ) {
        self.name = name
        self.introduction = introduction
        self.reviewCount = reviewCount
        self.price = price
    }
    
    var body: some View {
        HStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 16)
                .fill(.placeholder)
                .aspectRatio(5/7, contentMode: .fit)
                .frame(height: 140)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(name)
                    .bold()
                    .font(.title3)
                
                Text(introduction)
                    .font(.system(size: 14))
                
                HStack {
                    Text("리뷰 \(reviewCount.formatted())개")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    Text(price.formatted() + "원")
                        .bold()
                        .font(.title3)
                }
            }
            .padding(12)
        }
    }
}

#Preview {
    StudioProductCell()
}
