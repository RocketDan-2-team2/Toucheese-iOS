//
//  ReservationListView.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

import Combine

struct ReservationListView: View {
    
    private let orderService = DefaultOrderService()
    
    @State private var bag = Set<AnyCancellable>()
    
    @State private var reservationList: [ReservationEntity] = []
    
    var body: some View {
        VStack {
            if reservationList.isEmpty {
               Text("예약된 일정이 없습니다.")
                    .font(.system(size: 20, weight: .medium))
            } else {
                ScrollView {
                    VStack {
                        ForEach(reservationList, id:\.self) { reservation in
                            ReservationCell(reservation: reservation)
                        }
                        .padding(.top, 13)
                    }
                }
            }
        }
        .task {
            if !reservationList.isEmpty { return }
            
            fetchReservationList()
        }
        .refreshable {
            fetchReservationList()
        }
        .navigationTitle("예약 일정")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func fetchReservationList() {
        orderService.getOrderList()
            .sink { event in
                switch event {
                case .finished:
                    print("fetch reservation list!")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { list in
                self.reservationList = list
            }
            .store(in: &bag)
    }
    
}

#Preview {
    NavigationStack {
        ReservationListView()
    }
}
