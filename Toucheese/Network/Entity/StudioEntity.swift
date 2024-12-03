//
//  StudioEntity.swift
//  Toucheese
//
//  Created by 유지호 on 11/21/24.
//

import Foundation

struct StudioEntity: Codable, Hashable {
    let id: Int
    let name: String
    let profileImage: String?
    let popularity: Float?
    let portfolios: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, popularity, portfolios
        case profileImage = "profileImg"
    }
}
