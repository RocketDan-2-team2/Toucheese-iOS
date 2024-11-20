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
    func searchStudio(conceptID: String,
                      region: RegionType,
                      popularity: RatingType,
                      price: PriceType,
                      page: Int,
                      size: Int) -> AnyPublisher<Data, Error>
}

typealias DefaultStudioService = BaseService<StudioAPI>

extension DefaultStudioService: StudioService {
    
    func getStudioConceptList() -> AnyPublisher<[ConceptEntity], Error> {
        requestObjectWith(.concept)
    }
    
    func searchStudio(
        conceptID: String,
        region: RegionType,
        popularity: RatingType,
        price: PriceType,
        page: Int = 0,
        size: Int = 10
    ) -> AnyPublisher<Data, any Error> {
        requestObjectWithNetworkError(.search(
            conceptID: conceptID,
            parameters: ["region": region,
                         "popularity": popularity,
                         "price": price,
                         "page": page,
                         "size": size]
        ))
    }
    
}
