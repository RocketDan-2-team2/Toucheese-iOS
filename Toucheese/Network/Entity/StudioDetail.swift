//
//  StudioInfo.swift
//  Toucheese
//
//  Created by SunJoon Lee on 12/1/24.
//

import Foundation

/// 스튜디오 상세 정보
///
/// [스튜디오 상세 페이지]의 스튜디오 상세 정보로 사용할 데이터
struct StudioInfo {
    let id: Int
    let name: String
    let profileImage: String
    let backgrounds: [String]
    let popularity: Float
    let dutyDate: String
    let address: String
    let description: String
    
    static func mockData() -> StudioInfo {
        .init(
            id: 173,
            name: "레코디드(강남)",
            profileImage: "",
            backgrounds: [],
            popularity: 0.0,
            dutyDate: "목, 금, 토: 13:30-21:00, 월, 화, 수, 일: 13:30-20:00",
            address: "서울 강남구 봉은사로2길 24 3층 301호",
            description: ""
        )
    }
}

/// 스튜디오 상품 카테고리
enum ProductCategory: String, Hashable {
    /// 증명사진
    case id = "ID_PHOTO"
    /// 프로필 사진
    case profile = "PROFILE_PHOTO"
    /// 그외 촬영상품
    case unknown = "UNKNOWN"
    
    /// 케이스 설명 (한글)
    var description: String {
        switch self {
        case .id: "증명사진"
        case .profile: "프로필 사진"
        case .unknown: "그외 상품"
        }
    }
}

/// 스튜디오 리뷰
///
/// [스튜디오 상세 페이지]의 리뷰탭에서 사용할 리뷰 데이터
struct StudioReview {
    let id: Int
    let image: String
    
    static func mockData() -> StudioReview {
        .init(id: 1, image: "https://i.imgur.com/niY3nhv.jpeg")
    }
}


// MARK: - Entity


/// [스튜디오 상세 페이지]와 관련된 API용 구조체
struct StudioDetailEntity: Decodable {
    let studioInfoDto: Info
    let categorizedItems: [String: [Item]]?
    let reviewImageDtos: [ReviewImage]?
    
    /// 스튜디오 상세 정보(StudioInfo)로 변환하는 메서드
    func translateToInfo() -> StudioInfo {
        self.studioInfoDto.translate()
    }
    
    /// 스튜디오 상품 리스트를 [카테고리 : [상품]] 딕셔너리로 변환하는 메서드
    func translateToItems() -> [ProductCategory: [StudioProduct]] {
        if let categorizedItems {
            var result: [ProductCategory: [StudioProduct]] = [:]
            
            for (key, value) in categorizedItems {
                if let newKey = ProductCategory(rawValue: key) {
                    result[newKey] = value.map{ $0.translate() }
                }
            }
            
            return result
            
        } else {
            return [:]
        }
    }
    
    /// 스튜디오의 상품 리스트(배열)로 변환하는 메서드
    func translateToFlatItems() -> [StudioProduct] {
        
        var result: [StudioProduct] = []
        
        if let categorizedItems {
            for (_, value) in categorizedItems {
                result += value.map{ $0.translate() }
            }
        }
        
        return result
    }
    
    /// 스튜디오의 리뷰 리스트(배열)로 변환하는 메서드
    func translateToReviews() -> [StudioReview] {
        reviewImageDtos?.map { $0.translate() } ?? []
    }
    
    struct Info: Decodable {
        let studioId: Int
        let studioName: String
        let studioProfile: String?
        let studioBackgrounds: [String]
        let popularity: Float?
        let dutyDate: String
        let address: String
        let studioDescription: String?
        
        // MARK: 여기서, nil 처리를 해주는게 맞을까요?
        func translate() -> StudioInfo {
            .init(
                id: self.studioId,
                name: self.studioName,
                profileImage: self.studioProfile ?? "",
                backgrounds: self.studioBackgrounds,
                popularity: self.popularity ?? 0.0,
                dutyDate: dutyDate.isEmpty ? "운영 시간 정보가 없습니다." : self.dutyDate,
                address: self.address,
                description: self.studioDescription ?? ""
            )
        }
    }
    
    struct Item: Decodable {
        let itemId: Int
        let itemName: String
        let itemDescription: String?
        let reviewCounts: Int
        let price: Int
        let itemImage: String
        
        // MARK: 여기서, nil 처리를 해주는게 맞을까요?
        func translate() -> StudioProduct {
            .init(
                id: self.itemId,
                image: self.itemImage,
                name: self.itemName,
                description: self.itemDescription ?? "",
                reviewCount: self.reviewCounts,
                price: self.price,
                optionList: []
            )
        }
    }
    
    struct ReviewImage: Decodable {
        let reviewId: Int
        let imageUrl: String
        
        func translate() -> StudioReview {
            .init(
                id: self.reviewId,
                image: self.imageUrl
            )
        }
    }
}