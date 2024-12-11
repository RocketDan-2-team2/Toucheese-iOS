//
//  OrderEntity.swift
//  Toucheese
//
//  Created by 최주리 on 12/9/24.
//

import Foundation

struct OrderEntity: Encodable, Hashable {
    let name: String
    let email: String
    let phone: String
    let studioId: Int
    let orderDateTime: String
    let orderRequestItemDtos: [ItemRequestEntity]
}

struct ItemRequestEntity: Encodable, Hashable {
    let itemId: Int
    let itemQuantity: Int
    let orderRequestOptionDtos: [OptionRequestEntity]
}

struct OptionRequestEntity: Encodable, Hashable {
    let optionId: Int
    let optionQuantity: Int
}
