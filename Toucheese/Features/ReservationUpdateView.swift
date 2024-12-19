//
//  ReservationUpdateView.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

//TODO: 피그마와 같이 오른쪽 상단에 x를 할지 아니면 네비게이션으로 할지?
// 아니면 Fullscreencover로 할지... 상의하자 

struct ReservationUpdateView: View {
    
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
                //TODO: 예약 날짜 변경 페이지로 이동
                
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
    }
}

#Preview {
    NavigationStack {
        ReservationUpdateView()
    }
}