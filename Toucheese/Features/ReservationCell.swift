//
//  ReservationCell.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

struct ReservationCell: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    //임시
    let reservation: ReservationEntity
    let studioId: Int = 1
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                AsyncImage(url: URL(string: "")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    default:
                        Circle()
                            .fill(.clear)
                            .skeleton(
                                with: true,
                                appearance: .gradient(
                                    color: Color(uiColor: .lightGray).opacity(0.5),
                                    background: .clear
                                ),
                                shape: .circle
                            )
                    }
                }
                .frame(width: 56, height: 56)
                .clipShape(.circle)
                .background {
                    Circle()
                        .fill(.placeholder.opacity(0.3))
                }
                .padding(.trailing, 8)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Image(systemName: "calendar")
                            .padding(.trailing, 4)
                        Text(reservation.reservedDateTime)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.gray06)
                    }
                    .padding(.bottom, 4)
                    Text(reservation.studioName)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.bottom, 2)
                    Text(reservation.orderItemDto.first?.itemName)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.gray06)
                }
                Spacer()
                VStack {
                    ReservationStateTicket(type: reservation.status)
                    Spacer()
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
            
            Button(action: {
                //TODO: 상세 보기 API 호출 -> 파라미터로 detail 전달
//                navigationManager.push(.reservationDetailView(reservation: reservation))
            }, label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.primary01)
                    .stroke(.primary03)
                    .frame(height: 40)
                    .overlay {
                        Text("예약 상세 보기")
                            .font(.system(size: 14, weight: .bold))
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
            })
            .padding(.horizontal, 12)
            .padding(.bottom, 16)
        }
        .background {
            Color.white
                .mask(RoundedRectangle(cornerRadius: 24))
                .shadow(color: .gray03 ,radius: 4)
                
        }
        .padding(.horizontal, 16)
    }
}
