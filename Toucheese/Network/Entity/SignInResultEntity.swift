//
//  SignInResultEntity.swift
//  Toucheese
//
//  Created by 유지호 on 12/21/24.
//

import Foundation

struct SignInResultEntity: Decodable {
    let email: String?
    let username: String?
    let nickname: String?
    let phone: String?
    let profileImage: String?
    let tokens: AuthTokenEntity
    
    enum CodingKeys: String, CodingKey {
        case email, username, nickname, phone, tokens
        case profileImage = "profileImg"
    }
}
