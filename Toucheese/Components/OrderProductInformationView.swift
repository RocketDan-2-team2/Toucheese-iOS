//
//  OrderProductInformationView.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

struct OrderProductInformationView: View {
    
    let product: StudioProduct
    let studio: StudioInfo
    let selectedOptions: [StudioProductOption]
    let totalPrice: Int
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 52, height: 68)
            } placeholder: {
                //TODO: 스켈레톤 처리하기
                ProgressView()
            }
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 2) {
                    Image(.homeFilled)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                    Text("\(studio.name)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.gray06)
                }
                .padding(.bottom, 8)
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(product.name)")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.bottom, 6)
                        ForEach(selectedOptions) { option in
                            HStack(alignment: .center, spacing: 2) {
                                Image(.turnRight)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                Text("\(option.name)")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(.gray06)
                            }
                            .padding(.bottom, 4)
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(product.price)원")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.bottom, 6)
                        ForEach(selectedOptions) { option in
                            Text("+\(option.price)원")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(.gray06)
                                .padding(.bottom, 4)
                        }
                    }
                }
                HStack {
                    Spacer()
                    Text("총 \(totalPrice)원")
                        .font(.system(size: 16, weight: .bold))
                        .padding(.top, 8)
                }
            }
            .padding(.leading, 16)
        }
        .padding()
        .background(.gray01, in: RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray02)
        }
    }
}