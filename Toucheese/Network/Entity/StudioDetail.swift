//
//  StudioInfo.swift
//  Toucheese
//
//  Created by SunJoon Lee on 12/1/24.
//

import Foundation

/// 스튜디오 상세 정보
///
/// [스튜디오 상세 페이지] 스튜디오 상세 정보로 사용할 데이터
struct StudioInfo: Hashable {
    /// 스튜디오 ID
    let id: Int
    /// 스튜디오 이름
    let name: String
    /// 스튜디오 이미지 URL 문자열
    let profileImage: String
    /// 스튜디오 배경사진 URL 문자열들
    let backgrounds: [String]
    /// 스튜디오 별점
    let popularity: Float
    /// 스튜디오 근무일
    let dutyDate: String
    /// 스튜디오 주소
    let address: String
    /// 스튜디오 설명 (알림, notice)
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

/// 스튜디오 상품
///
/// [스튜디오 상세 페이지] 상품탭에서 사용할 상품 데이터
struct StudioItem: Identifiable {
    /// 상품 ID
    let id: Int
    /// 상품 이름
    let name: String
    /// 상품 카테고리 (사용하지 않아서 주석처림함)
//    let category: String
    /// 상품 설명
    let description: String
    /// 상품 리뷰 개수
    let reviewCount: Int
    /// 상품 가격
    let price: Int
    /// 상품 이미지 URL 문자열
    let image: String
}

/// 스튜디오 리뷰
///
/// [스튜디오 상세 페이지] 리뷰탭에서 사용할 리뷰 데이터
struct StudioReview {
    /// 리뷰 ID
    let id: Int
    /// 이미지 URL 문자열
    let image: String
    
    static func mockData() -> StudioReview {
        .init(id: 1, image: "https://i.imgur.com/niY3nhv.jpeg")
    }
}


// MARK: - Entity


/// [스튜디오 상세 페이지]와 관련된 API용 구조체
struct StudioDetailEntity: Decodable {
    let studioInfoDto: Info
    let items: [Item]?
    let reviewImageDtos: [ReviewImage]?
    
    /// 스튜디오 상세 정보(StudioInfo)로 변환하는 메서드
    func translateToInfo() -> StudioInfo {
        self.studioInfoDto.translate()
    }
    
    /// 스튜디오 상품 리스트(배열)로 변환하는 메서드
    func translateToItems() -> [StudioItem] {
        self.items?.map{ $0.translate() } ?? []
    }
    
    /// 스튜디오 리뷰 리스트(배열)로 변환하는 메서드
    func translateToReviews() -> [StudioReview] {
        self.reviewImageDtos?.map{ $0.translate() } ?? []
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
        let itemCategory: String?
        let itemDescription: String?
        let reviewCounts: Int
        let price: Int
        let itemImage: String
        
        func translate() -> StudioItem {
            .init(
                id: self.itemId,
                name: self.itemName,
                description: self.itemDescription ?? "",
                reviewCount: self.reviewCounts,
                price: self.price,
                image: self.itemImage
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
