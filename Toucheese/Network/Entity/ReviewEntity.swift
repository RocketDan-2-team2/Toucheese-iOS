//
//  ReviewEntity.swift
//  Toucheese
//
//  Created by 최주리 on 12/2/24.
//

import Foundation

struct ReviewEntity: Decodable, Hashable {
    let reviewDto: Review
    let userProfileDto: UserProfile
}

struct Review: Decodable, Hashable {
    let imageUrl: [String]
    let description: String
}

struct UserProfile: Decodable, Hashable {
    let name: String
    let profileImg: String
}
