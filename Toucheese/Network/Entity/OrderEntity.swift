//
//  OrderEntity.swift
//  Toucheese
//
//  Created by 최주리 on 12/9/24.
//

import Foundation

//TODO: API 정보 받으면 바꾸기
struct OrderEntity: Encodable, Hashable {
    let name: String
    let email: String
    let phone: String
    let studioID: Int
    let orderDateTime: String
    let itemDto: [ItemDTO]
}

struct ItemDTO: Encodable, Hashable {
    let itemId: Int
    let itemQuantity: Int
    let optionDtoList: [OptionDTO]
}

struct OptionDTO: Encodable, Hashable {
    let optionId: Int
    let optionQuantity: Int
}
