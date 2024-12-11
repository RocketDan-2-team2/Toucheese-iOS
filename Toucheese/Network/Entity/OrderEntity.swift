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
    //TODO: 여기 왜 배열인지 물어보기
    let itemDtos: [ItemDTO]
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
