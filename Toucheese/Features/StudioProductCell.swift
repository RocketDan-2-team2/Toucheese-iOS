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
                        .padding(.bottom, 8)
                    
                    Text(product.description)
                        .font(.system(size: 14))
                    
                    Spacer()
                }
                
                Text(product.price.formatted() + "원")
                    .font(.system(size: 18, weight: .bold))
                
                HStack(spacing: 4) {
                    Image(systemName: "message")
                    
                    Text("리뷰 \(product.reviewCount.formatted())개")
                }
                .font(.system(size: 12))
                .foregroundStyle(.gray)
                .padding(.bottom, 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
            
            AsyncImage(url: URL(string: product.image)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    Rectangle()
                        .fill(.clear)
                        .skeleton(
                            with: true,
                            appearance: .gradient(
                                color: Color(uiColor: .lightGray).opacity(0.5),
                                background: .clear
                            ),
                            shape: .rectangle
                        )
                }
            }
            .frame(width: 100, height: 140)
            .clipShape(.rect(cornerRadius: 8))
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.placeholder.opacity(0.3))
                    .fill(.placeholder.opacity(0.3))
            }
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
    StudioProductCell(product: StudioItem(
        id: 2,
        name: "응애",
        description: "응애응애응애",
        reviewCount: 4,
        price: 3000,
        image: ""
    ))
}
