//
//  ReservationEntity.swift
//  Toucheese
//
//  Created by 최주리 on 12/23/24.
//

import Foundation

struct ReservationEntity: Decodable, Hashable {
    let orderId: Int
    let orderUserDto: OrderUserEntity
    let studioName: String
    let reservedDateTime: String
    let orderItemDto: [OrderItem]
    let status: ReservationStateType
}

struct OrderUserEntity: Decodable, Hashable {
    let userId: Int
    let userName: String
}

struct OrderItem: Decodable, Hashable {
    let itemId: Int
    let itemName: String
}


// 임시
struct ReservationDetail: Decodable, Hashable {
    let studiName: String
    let date: String
    let orderItem: String
    let ordererName: String
}
