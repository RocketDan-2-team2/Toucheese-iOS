//
//  OrderView.swift
//  Toucheese
//
//  Created by 최주리 on 12/6/24.
//

import SwiftUI

struct OrderView: View {
    
    @State private var selectedPayment: PaymentType = .PG
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("내 정보")
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                HStack {
                    VStack(alignment: .leading) {
                        Text("성함")
                        Text("연락처")
                        Text("이메일")
                    }
                    VStack(alignment: .leading) {
                        Text("강미미")
                        Text("010-9593-3561")
                        Text("kan0@gmail.com")
                    }
                    .padding(.leading, 50)
                }
            }
            .padding(.vertical)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("상품 확인")
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                HStack {
                    AsyncImage(url: URL(string: "https://i.imgur.com/niY3nhv.jpeg")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    } placeholder: {
                        //TODO: 스켈레톤 처리하기
                        ProgressView()
                    }
                    VStack(alignment: .leading) {
                        Text("공원스튜디오")
                            .fontWeight(.bold)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("증명 사진")
                                Text("보정 사진 추가")
                                Text("예약 날짜")
                            }
                            VStack(alignment: .trailing) {
                                Text("75,000원")
                                Text("30,000원")
                                Text("2024-12-05 오후 2시")
                            }
                        }
                    }
                }
            }
            .padding(.vertical)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("결제수단")
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                ForEach(PaymentType.allCases, id: \.self) { type in
                    PaymentRadioButton(type: type, selectedType: $selectedPayment)
                        .padding(.vertical, 1)
                }
            }
            .padding(.vertical)
            
            Spacer()
            
            Button {
                
            } label: {
                Capsule()
                    .fill(.yellow)
                    .frame(height: 40)
                    .overlay {
                        Text("결제하기 (₩\(200000)")
                            .fontWeight(.bold)
                    }
            }
            .buttonStyle(.plain)
        }
        .padding()
        .navigationTitle("주문/결제")
        .toolbarRole(.editor)
    }
}

#Preview {
    OrderView()
}
