//
//  StudioProduct.swift
//  Toucheese
//
//  Created by 유지호 on 11/27/24.
//

import Foundation

// MARK: 임시 필드들. 추후 서버 연동 시 필드값 변동 예정
struct StudioProduct: Identifiable, Hashable {
    let id: String
    let name: String
    let introduction: String
    let reviewCount: Int
    let price: Int
    
    static let mockData: [StudioProduct] = [
        .init(
            id: UUID().uuidString,
            name: "상품 이름",
            introduction: "상품 소개\n상품 소개\n상품 소개",
            reviewCount: 1234,
            price: 123456
        ),
        .init(
            id: UUID().uuidString,
            name: "상품 이름",
            introduction: "상품 소개\n상품 소개\n상품 소개",
            reviewCount: 1234,
            price: 123456
        ),
        .init(
            id: UUID().uuidString,
            name: "상품 이름",
            introduction: "상품 소개\n상품 소개\n상품 소개",
            reviewCount: 1234,
            price: 123456
        ),
        .init(
            id: UUID().uuidString,
            name: "상품 이름",
            introduction: "상품 소개\n상품 소개\n상품 소개",
            reviewCount: 1234,
            price: 123456
        ),
        .init(
            id: UUID().uuidString,
            name: "상품 이름",
            introduction: "상품 소개\n상품 소개\n상품 소개",
            reviewCount: 1234,
            price: 123456
        )
    ]
}
