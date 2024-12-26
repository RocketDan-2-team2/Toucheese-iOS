//
//  ReservationListView.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

import Combine

struct ReservationListView: View {
    
    let orderService = DefaultOrderService()
    @State private var reservationList: [ReservationEntity] = []
    
    @State private var bag = Set<AnyCancellable>()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(reservationList, id:\.self) { reservation in
                    ReservationCell(reservation: reservation)
                }
                .padding(.top, 13)
            }
            .onAppear {
                fetchReservationList()
            }
        }
        .navigationTitle("예약 일정")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func fetchReservationList() {
        orderService.getOrderList()
            .sink { event in
                switch event {
                case .finished:
                    print("")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { list in
                reservationList = list
            }
            .store(in: &bag)
    }

}

#Preview {
    NavigationStack {
        ReservationListView()
    }
}
