//
//  StudioSearchResultEntity.swift
//  Toucheese
//
//  Created by 유지호 on 11/21/24.
//

import Foundation

struct StudioSearchResultEntity: Codable {
    let content: [StudioEntity]
    let pageable: Pageable
    let last: Bool
    let totalPages: Int
    let totalElements: Int
    let first: Bool
    let size: Int
    let number: Int
    let sort: Sort
    let numberOfElements: Int
    let empty: Bool
}

struct Pageable: Codable {
    let pageNumber: Int
    let pageSize: Int
    let sort: Sort
    let offset: Int
    let unpaged: Bool
    let paged: Bool
}

struct Sort: Codable {
    let empty: Bool
    let unsorted: Bool
    let sorted: Bool
}
