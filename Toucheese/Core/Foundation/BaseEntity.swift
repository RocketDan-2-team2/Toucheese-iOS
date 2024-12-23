//
//  BaseEntity.swift
//  Toucheese
//
//  Created by 유지호 on 12/23/24.
//

import Foundation

struct BaseEntity<T: Decodable>: Decodable {
    let status: Int
    let message: String
    let data: T?
    let error: ErrorEntity?
}
