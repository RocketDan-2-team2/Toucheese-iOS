//
//  ReservationDetailView.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

import Combine

struct ReservationDetailView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    private let orderService = DefaultOrderService()
    @State private var bag = Set<AnyCancellable>()
    
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
                        navigationManager.alert = .reservationCancel(action: {
                            cancelReservation(orderID: 1)
                        })
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
                            //TODO: 스튜디오 운영 시간 API 호출 fetchStudioHours??
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
        .navigationBarBackButtonHidden(navigationManager.alert != nil)
    }
    
    //MARK: - Network
    
    private func cancelReservation(orderID: Int) {
        orderService.cancelOrder(orderID: orderID)
            .sink { event in
                switch event {
                case .finished:
                    print("Cancel Reservation finished: \(event)")
                case .failure(let error):
                    print(error.localizedDescription)
                    //TODO: 취소 실패 toast
                }
            } receiveValue: { result in
                if result {
                    navigationManager.pop(1)
                    //TODO: 취소 성공 toast
                } else {
                    //TODO: 취소 실패 toast
                }
            }
            .store(in: &bag)
    }
}

#Preview {
    NavigationStack {
        ReservationDetailView(reservationStateType: .confirm)
            .environmentObject(NavigationManager())
    }
}
