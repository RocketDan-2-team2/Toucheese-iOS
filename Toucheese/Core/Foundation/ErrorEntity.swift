//
//  ErrorEntity.swift
//  Toucheese
//
//  Created by 유지호 on 11/19/24.
//

struct ErrorEntity: Decodable, Error {
    let code: Int
    let message: String
}
