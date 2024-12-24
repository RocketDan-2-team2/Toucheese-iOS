//
//  BaseEntity.swift
//  Toucheese
//
//  Created by 유지호 on 12/23/24.
//

import Foundation

struct BaseEntity<T: Decodable>: Decodable {
    let success: Bool
    let payload: T?
    let error: ErrorEntity?
}
