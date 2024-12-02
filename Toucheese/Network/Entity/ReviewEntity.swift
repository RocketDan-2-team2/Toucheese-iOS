//
//  ReviewEntity.swift
//  Toucheese
//
//  Created by 최주리 on 12/2/24.
//

import Foundation

struct ReviewEntity: Decodable {
    let reviewDto: Review
    let userProfileDto: UserProfile
}

struct Review: Decodable {
    let imageUrl: [String]
    let description: String
}

struct UserProfile: Decodable {
    let name: String
    let profileImg: String
}
