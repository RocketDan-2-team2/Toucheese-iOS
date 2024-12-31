//
//  ReservationEntity.swift
//  Toucheese
//
//  Created by 최주리 on 12/23/24.
//

import Foundation

struct ReservationEntity: Decodable, Hashable {
    let orderId: Int
    let studioId: Int?
    let orderUserDto: OrderUserEntity
    let studioName: String
    let reservedDateTime: String
    let orderItemDto: OrderItemEntity
    let status: ReservationStateType
    let studioImage: String?
}

struct OrderUserEntity: Decodable, Hashable {
    let userId: Int
    let userName: String
    let userEmail: String?
    let userPhone: String?
    
    func translate() -> User {
        .init(
            name: self.userName,
            phone: self.userPhone ?? "",
            email: self.userEmail ?? ""
        )
    }
}

struct OrderItemEntity: Decodable, Hashable {
    let itemId: Int
    let itemName: String
    let itemImage: String?
    let quantity: Int
    let itemPrice: Int?
    let totalPrice: Int?
    let orderOptionDtos: [OrderOptionEntity]?
    
    func translate() -> StudioProduct {
        .init(
            id: self.itemId,
            image: self.itemImage,
            name: self.itemName,
            description: "",
            reviewCount: 0,
            price: self.totalPrice ?? 0,
            optionList: []
        )
    }
    
}

struct OrderOptionEntity: Decodable, Hashable {
    let id: Int
    let name: String
    let price: Int
    let quantity: Int
    
    func translate() -> StudioProductOption {
        .init(
            id: self.id,
            name: self.name,
            description: "",
            price: self.price,
            count: quantity
        )
    }
}
