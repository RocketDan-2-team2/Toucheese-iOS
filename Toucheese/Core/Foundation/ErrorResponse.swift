//
//  ErrorResponse.swift
//  Toucheese
//
//  Created by 유지호 on 11/19/24.
//

struct ErrorResponse: Decodable, Equatable {
    let code: Int
    let message: String
}
