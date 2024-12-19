//
//  ReservationDetailView.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

struct ReservationDetailView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let reservationStateType: ReservationStateType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                Text("예약 정보")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.vertical, 14)
                OrderStudioInformationView(studio: StudioInfo(id: 0, name: "멋사스튜디오", profileImage: "", backgrounds: [], popularity: 4.5, dutyDate: "", address: "", description: ""), selectedDateString: "12월 24일(화) 오후 01:00")
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Rectangle()
                    .frame(height: 8)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.gray02)
                    .padding(.horizontal, -16)
                Text("주문 상품")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.vertical, 14)
                OrderProductInformationView(product: StudioProduct(id: 0, image: nil, name: "", description: "", reviewCount: 0, price: 0, optionList: []), studio: StudioInfo(id: 0, name: "멋사스튜디오", profileImage: "", backgrounds: [], popularity: 4.5, dutyDate: "", address: "", description: ""), selectedOptions: [], totalPrice: 105000)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Rectangle()
                    .frame(height: 8)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.gray02)
                    .padding(.horizontal, -16)
                Text("주문자 정보")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.vertical, 14)
                OrderUserInformationView()
            }
            
            Spacer()
            
            if reservationStateType == .waiting || reservationStateType == .confirm {
                
                HStack {
                    Button(action: {
                        //TODO: 예약 취소 알럿 띄우기
                        
                    }, label: {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.gray02)
                            .frame(height: 48)
                            .overlay {
                                Text("예약 취소하기")
                                    .font(.system(size: 16, weight: .bold))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                            }
                    })
                    
                    if reservationStateType == .waiting {
                        Button(action: {
                            //TODO: 예약 날짜 변경 페이지로 이동
                            navigationManager.push(
                                .reservationUpdateView
                            )
                        }, label: {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.primary06)
                                .frame(height: 48)
                                .overlay {
                                    Text("예약날짜 변경하기")
                                        .font(.system(size: 16, weight: .bold))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black)
                                }
                        })
                    }
                }
                .padding(.bottom, 8)
            }
            
        }
        .padding(16)
        .navigationTitle("예약 상세 보기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        ReservationDetailView(reservationStateType: .confirm)
    }
}
