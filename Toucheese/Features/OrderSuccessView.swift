//
//  OrderSuccessView.swift
//  Toucheese
//
//  Created by 최주리 on 12/6/24.
//

import SwiftUI

struct OrderSuccessView: View {
    
    let studio: StudioInfo
    let product: StudioProduct
    let totalPrice: Int
    let selectedDate: Date
    let selectedOptions: [StudioProductOption]
    
    var body: some View {
        VStack(spacing: 0) {
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 40))
                .foregroundStyle(.yellow)
                .padding(.top, 220)
                .padding(.bottom, 13)
            Text("예약이 접수되었습니다!")
                .font(.system(size: 20, weight: .bold))
                .padding(.bottom, 32)
            
            VStack(spacing: 0) {
                Text("\(studio.name)")
                    .font(.system(size: 16, weight: .bold))
                //TODO: 날짜 받으면 바꾸기
                Text("12월 24일(화) 오후 02:00")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.blue)
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
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
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(product.name)")
                                    .font(.system(size: 14, weight: .semibold))
                                ForEach(selectedOptions) { option in
                                    Text("-\(option.name)")
                                        .font(.system(size: 12, weight: .regular))
                                }
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("\(product.price)원")
                                    .font(.system(size: 14, weight: .semibold))
                                ForEach(selectedOptions) { option in
                                    Text("+\(option.price)원")
                                        .font(.system(size: 12, weight: .regular))
                                }
                            }
                        }
                        HStack {
                            Spacer()
                            Text("총 \(totalPrice)원")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.blue)
                                .padding(.top, 8)
                        }
                    }
                    .padding(.leading, 16)
                }
            }
            .padding()
            .background(.gray, in: RoundedRectangle(cornerRadius: 8))
            
            Spacer()
            
            HStack {
                Button(action: {
                    
                }, label: {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.gray)
                        .frame(height: 48)
                        .overlay {
                            Text("홈화면 가기")
                                .font(.system(size: 16, weight: .bold))
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                        }
                })
                Button(action: {
                    
                }, label: {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.yellow)
                        .frame(height: 48)
                        .overlay {
                            Text("예약내역 보기")
                                .font(.system(size: 16, weight: .bold))
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                        }
                })
            }
            .padding(.bottom, 8)
        }
        .padding(.horizontal, 16)
        .toolbar(.hidden)
    }
}

#Preview {
    OrderSuccessView(studio: .init(id: 0, name: "공원스튜디오", profileImage: "", backgrounds: [], popularity: 0, dutyDate: "", address: "", description: ""), product: .init(id: 0, image: "", name: "증명사진", description: "", reviewCount: 0, price: 75000, optionList: [.init(id: 0, name: "보정사진 추가", description: "", price: 30000, count: 1)]), totalPrice: 105000, selectedDate: Date(), selectedOptions: [])
}

