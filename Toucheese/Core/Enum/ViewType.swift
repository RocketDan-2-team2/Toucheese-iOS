//
//  ViewType.swift
//  Toucheese
//
//  Created by 최주리 on 12/12/24.
//

import Foundation

enum ViewType: Hashable {
    
    //MARK: - Home Tab
    
    case conceptView
    case studioListView(concept: ConceptEntity)
    
    case studioDetailView(studioId: Int)
    case studioProductDetailView(studio: StudioInfo, product: StudioProduct, hoursRawData: [StudioHoursEntity])
    case reviewDetailView(review: Review, user: UserProfile)
    
    case orderView(studio: StudioInfo, product: StudioProduct, totalPrice: Int, selectedDate: Date, user: User)
    case orderSuccessView(studio: StudioInfo, product: StudioProduct, totalPrice: Int, selectedDate: String, selectedOptions: [StudioProductOption])
    
    //MARK: - Reservation Tab

    case reservationListView
    case reservationDetailView(reservation: ReservationEntity)
    case reservationUpdateView(reservation: ReservationEntity, hoursRawData: [StudioHoursEntity], changeDate: Date)
    
}
