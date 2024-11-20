//
//  ConceptEntity.swift
//  Toucheese
//
//  Created by 유지호 on 11/20/24.
//

import Foundation

struct ConceptEntity: Codable, Identifiable {
    let id: Int
    let name: String
    let conceptImage: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case conceptImage = "conceptImg"
    }
}
