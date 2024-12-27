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
    
    private let orderService = MockOrderService()
    private let studioService = DefaultStudioService()
    @State private var bag = Set<AnyCancellable>()

    let reservation: ReservationEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                Text("예약 정보")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.vertical, 14)
                OrderStudioInformationView(
                    studioName: reservation.studioName,
                    selectedDateString: reservation.reservedDateTime.toDate()?.getDateString() ?? ""
                )
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

                OrderProductInformationView(
                    product: reservation.orderItemDto.translate(),
                    studioName: reservation.studioName,
                    selectedOptions: reservation.orderItemDto.orderOptionDtos?.map { $0.translate() } ?? [],
                    totalPrice: reservation.orderItemDto.totalPrice ?? 0
                )
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
                OrderUserInformationView(user: reservation.orderUserDto.translate())
            }
            
            Spacer()
            
            if reservation.status == .waiting || reservation.status == .confirm {
                
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
                    
                    if reservation.status == .waiting {
                        Button(action: {
                            fetchStudioHours()
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
                    navigationManager.toast = .cancelFail
                }
            } receiveValue: { result in
                if result {
                    navigationManager.pop(1)
                    navigationManager.toast = .cancelSuccess(date: reservation.reservedDateTime.toDate()?.getDateString() ?? "")
                } else {
                    navigationManager.toast = .cancelFail
                }
            }
            .store(in: &bag)
    }
    
    private func fetchStudioHours() {
        studioService.getStudioHours(studioID: reservation.studioId ?? 0)
            .sink { event in
                switch event {
                case .finished:
                    print("Event: \(event)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { data in
                navigationManager.push(
                    .reservationUpdateView(reservation: reservation, hoursRawData: data, changeDate: reservation.reservedDateTime.toDate() ?? Date())
                )
            }
            .store(in: &bag)
    }
}
