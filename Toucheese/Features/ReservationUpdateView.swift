//
//  ReservationUpdateView.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

struct ReservationUpdateView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let hoursRawData: [StudioHoursEntity] = []
    @State private var selectedDate: Date = .now
    
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
                    selectedDate: $selectedDate,
                    hoursRawData: hoursRawData)
            }
            Spacer()
            Button(action: {
                //TODO: API 호출
                navigationManager.pop(2)
                navigationManager.alert = .dateChanged(date: selectedDate.getDateString())
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
}

#Preview {
    NavigationStack {
        ReservationUpdateView()
    }
}
