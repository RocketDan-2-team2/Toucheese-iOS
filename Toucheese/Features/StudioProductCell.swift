//
//  StudioProductCell.swift
//  Toucheese
//
//  Created by 유지호 on 11/26/24.
//

import SwiftUI
import SkeletonUI

struct StudioProductCell: View {
    private let product: StudioItem
    
    init(product: StudioItem) {
        self.product = product
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(product.name)
                        .font(.system(size: 16, weight: .bold))
                    
                    Text(product.description)
                        .font(.system(size: 14))
                        .padding(.vertical, 8)
                 
                    if product.reviewCount > 0 {
                        HStack(spacing: 4) {
                            Image(systemName: "message")
                            
                            Text("리뷰 \(product.reviewCount.formatted())개")
                        }
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                        .padding(.bottom, 2)
                    }
                    
                    Spacer()
                }
                
                Text(product.price.formatted() + "원")
                    .font(.system(size: 18, weight: .bold))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
            
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle()
                    .fill(.clear)
                    .skeleton(
                        with: true,
                        appearance: .gradient(
                            color: Color(uiColor: .lightGray).opacity(0.2)
                        ),
                        shape: .rectangle
                    )
            }
            .frame(width: 100, height: 140)
            .background(.placeholder)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.placeholder.opacity(0.3))
            }
            .clipShape(.rect(cornerRadius: 8))
        }
        .frame(height: 140)
        .padding()
        .contentShape(.rect)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .shadow(
                    color: .black.opacity(0.1),
                    radius: 10,
                    y: 2
                )
        }
        .padding(.horizontal)
    }
}

#Preview {
    Group {
        StudioProductCell(product: StudioItem(
            id: 2,
            name: "응애",
            description: "응애응애응애",
            reviewCount: 4,
            price: 3000,
            image: ""
        ))
        
        StudioProductCell(product: StudioItem(
            id: 2,
            name: "응애",
            description: "응애응애응애",
            reviewCount: 0,
            price: 3000,
            image: "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fimg.flayus.com%2Ffiles%2Fattach%2Fimages%2F425025%2F905%2F553%2F106%2Ffee411bdc98d0c301eb145f4ff1cf64a.jpg&type=sc960_832"
        ))
    }
}
