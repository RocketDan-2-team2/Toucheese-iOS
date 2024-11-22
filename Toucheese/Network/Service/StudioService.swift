//
//  StudioService.swift
//  Toucheese
//
//  Created by 유지호 on 11/20/24.
//

import Foundation
import Combine
import Moya

// TODO: 기본값 설정하는 방법 생각해보기
protocol StudioService {
    func getStudioConceptList() -> AnyPublisher<[ConceptEntity], Error>
    func getStudioList(conceptID: Int,
                      page: Int,
                      size: Int) -> AnyPublisher<StudioSearchResultEntity, Error>
    func searchStudio(conceptID: Int,
                      region: RegionType,
                      popularity: RatingType,
                      price: PriceType,
                      page: Int,
                      size: Int) -> AnyPublisher<StudioSearchResultEntity, Error>
}

typealias DefaultStudioService = BaseService<StudioAPI>

extension DefaultStudioService: StudioService {
    
    func getStudioConceptList() -> AnyPublisher<[ConceptEntity], Error> {
        requestObjectWith(.concept)
    }
    
    func getStudioList(
        conceptID: Int,
        page: Int,
        size: Int
    ) -> AnyPublisher<StudioSearchResultEntity, any Error> {
        requestObjectWithNetworkError(.search(
            conceptID: conceptID,
            parameters: [
                "pageable": ["page": page, "size": 10]
            ]
        ))
    }
    
    func searchStudio(
        conceptID: Int,
        region: RegionType,
        popularity: RatingType,
        price: PriceType,
        page: Int,
        size: Int
    ) -> AnyPublisher<StudioSearchResultEntity, any Error> {
        requestObjectWithNetworkError(.search(
            conceptID: conceptID,
            parameters: [
                "filters": ["region": region.key],
                "pageable": ["page": page, "size": 10]
            ]
        ))
    }
    
}
