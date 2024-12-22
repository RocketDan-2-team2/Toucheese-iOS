//
//  SignInResultEntity.swift
//  Toucheese
//
//  Created by 유지호 on 12/21/24.
//

import Foundation

struct SignInResultEntity: Decodable {
    let accessToken: String
    let refreshToken: String
    
    /// AccessToken의 발행일
    let issuedAt: Date
    
    /// AccessToken의 만료일
    let expiration: Date
}
