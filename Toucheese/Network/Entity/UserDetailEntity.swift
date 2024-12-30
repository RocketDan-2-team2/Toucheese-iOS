//
//  UserDetailEnity.swift
//  Toucheese
//
//  Created by SunJoon Lee on 12/30/24.
//

import Foundation

struct UserDetailEntity: Codable {
    let id: Int
    let email: String
    let password: String?
    let username: String?
    let nickname: String?
    let phone: String?
    let profileImg: String?
    let role: String
    let socialProvider: String
    
    func translate() -> UserEntity {
        UserEntity(name: username ?? "-", phone: phone ?? "-", email: email)
    }
}
