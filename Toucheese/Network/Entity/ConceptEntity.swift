//
//  ConceptEntity.swift
//  Toucheese
//
//  Created by 유지호 on 11/20/24.
//

import Foundation

struct ConceptEntity: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case image = "conceptImg"
    }
}


struct Concept: Identifiable, Hashable {
    var id: Int
    var type: ConceptType
    var image: String
}


enum ConceptType {
    case flashGlossy
    case blackBlueActor
    case natural
    case vibrant
    case wartercolorGrainy
    case clearDollLike
    
    var name: String {
        switch self {
        case .flashGlossy:
            "생동감 있는 실물 느낌"
        case .blackBlueActor:
            "흑백/블루 배우 느낌"
        case .natural:
            "내추럴 화보 느낌"
        case .vibrant:
            "플래쉬/아이돌 느낌"
        case .wartercolorGrainy:
            "필터/수채화 그림체 느낌"
        case .clearDollLike:
            "선명하고 인형같은 느낌"
        }
    }
    
    var type: String {
        switch self {
        case .flashGlossy:
            "FLASHY_GLOSSY"
        case .blackBlueActor:
            "BLACK_BLUE_ACTOR"
        case .natural:
            "NATURAL_PHOTO"
        case .vibrant:
            "VIBRANT"
        case .wartercolorGrainy:
            "WATERCOLOUR_GRAINY"
        case .clearDollLike:
            "CLEAR_DOLL_LIKE"
        }
    }
    
    init?(type: String) {
        switch type {
        case "FLASHY_GLOSSY":
            self = .flashGlossy
        case "BLACK_BLUE_ACTOR":
            self = .blackBlueActor
        case "NATURAL_PHOTO":
            self = .natural
        case "VIBRANT":
            self = .vibrant
        case "WATERCOLOUR_GRAINY":
            self = .wartercolorGrainy
        case "CLEAR_DOLL_LIKE":
            self = .clearDollLike
        default:
            return nil
        }
    }
}
