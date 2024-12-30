//
//  ReservationUpdateView.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

import Combine

struct ReservationUpdateView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let orderService = DefaultOrderService()
    @State private var bag = Set<AnyCancellable>()
    
    let reservation: ReservationEntity
    let hoursRawData: [StudioHoursEntity]
    @State var changeDate: Date
    
    @State private var isTimeSelected: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                HStack {
                    Text("변경하실 날짜와 시간을 선택해주세요.")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.vertical, 15.5)
                    Spacer()
                }

                BookingTimePicker(
                    selectedDate: $changeDate,
                    hoursRawData: hoursRawData,
                    isTimeSelected: $isTimeSelected
                )
            }
            .scrollIndicators(.hidden)
            
            Spacer()
            
            Button(action: {
                updateReservation()
            }, label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.primary06)
                    .frame(height: 48)
                    .overlay {
                        Text("변경하기")
                            .font(.system(size: 16, weight: .bold))
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
            })
            .padding(.vertical, 8)
        }
        .padding(.horizontal, 16)
        .navigationTitle("예약 날짜 변경")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .navigationBarBackButtonHidden(navigationManager.alert != nil)
    }
    
    //MARK: - Network
    
    private func updateReservation() {
        guard let studioId = reservation.studioId,
        let options = reservation.orderItemDto.orderOptionDtos else { return }
        
        var optionList: [OptionRequestEntity] = []
        for option in options {
            let newOption = OptionRequestEntity(optionId: option.id, optionQuantity: 1)
            optionList.append(newOption)
        }
        let item = ItemRequestEntity(
            itemId: reservation.orderItemDto.itemId,
            itemQuantity: 1,
            orderRequestOptionDtos: optionList
        )
        
        let updateReservation = UpdateOrderEntity(
            studioId: studioId,
            orderDateTime: changeDate.getISODateString(),
            orderRequestItemDtos: [item]
        )

        orderService.updateOrder(orderId: reservation.orderId, order: updateReservation)
            .sink { event in
                switch event {
                case .finished:
                    print("Success: \(event)")
                case .failure(let error):
                    print(error.localizedDescription)
                    navigationManager.toast = .orderFail
                }
            } receiveValue: { result in
                if result {
                    navigationManager.popToRoot()
                    navigationManager.alert = .dateChanged(date: changeDate.getDateString())
                } else {
                    navigationManager.toast = .reservationUpdateFail
                }
            }
            .store(in: &bag)
    }
}
