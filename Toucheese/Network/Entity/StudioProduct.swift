//
//  StudioProduct.swift
//  Toucheese
//
//  Created by 유지호 on 11/27/24.
//

import Foundation

// MARK: 임시 필드들. 추후 서버 연동 시 필드값 변동 예정
struct StudioProduct: Identifiable, Hashable {
    let id: Int
    let image: String?
    let name: String
    let description: String
    let reviewCount: Int
    let price: Int
    var optionList: [StudioProductOption]
    
    static let mockData: [StudioProduct] = [
        .init(
            id: 0,
            image: nil,
            name: "상품 이름",
            description: "상품 소개\n상품 소개\n상품 소개",
            reviewCount: 1234,
            price: 123456,
            optionList: []
        ),
        .init(
            id: 1,
            image: nil,
            name: "상품 이름",
            description: "상품 소개\n상품 소개\n상품 소개",
            reviewCount: 1234,
            price: 123456,
            optionList: []
        ),
        .init(
            id: 2,
            image: nil,
            name: "상품 이름",
            description: "상품 소개\n상품 소개\n상품 소개",
            reviewCount: 1234,
            price: 123456,
            optionList: []
        ),
        .init(
            id: 3,
            image: nil,
            name: "상품 이름",
            description: "상품 소개\n상품 소개\n상품 소개",
            reviewCount: 1234,
            price: 123456,
            optionList: []
        ),
        .init(
            id: 4,
            image: nil,
            name: "상품 이름",
            description: "상품 소개\n상품 소개\n상품 소개",
            reviewCount: 1234,
            price: 123456,
            optionList: []
        )
    ]
}

struct StudioProductOption: Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String
    let price: Int
    var count: Int
}

struct StudioProductEntity: Decodable {
    let itemInfoDto: ItemInfo
    let optionDtoList: [Option]
    
    func translate() -> StudioProduct {
        .init(
            id: self.itemInfoDto.itemId,
            image: self.itemInfoDto.itemImage,
            name: self.itemInfoDto.itemName,
            description: self.itemInfoDto.itemDescription ?? "",
            reviewCount: 0,
            price: self.itemInfoDto.itemPrice,
            optionList: self.optionDtoList.map { $0.translate() }
        )
    }
    
    struct ItemInfo: Decodable {
        let itemId: Int
        let itemImage: String?
        let itemName: String
        let itemDescription: String?
        let itemPrice: Int
    }
    
    struct Option: Decodable {
        let optionId: Int
        let optionName: String
        let optionDescription: String?
        let optionPrice: Int
        
        func translate() -> StudioProductOption {
            .init(
                id: self.optionId,
                name: self.optionName,
                description: self.optionDescription ?? "",
                price: self.optionPrice,
                count: 0
            )
        }
    }
}
