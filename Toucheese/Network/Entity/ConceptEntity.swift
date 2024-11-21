//
//  ConceptEntity.swift
//  Toucheese
//
//  Created by 유지호 on 11/20/24.
//

import Foundation

struct ConceptEntity: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case image = "conceptImg"
    }
}
