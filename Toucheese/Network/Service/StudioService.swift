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
                      region: RegionType?,
                      popularity: RatingType?,
                      price: PriceType?,
                      page: Int,
                      size: Int) -> AnyPublisher<StudioSearchResultEntity, Error>
}


final class DefaultStudioService: BaseService<StudioAPI> { }

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
            parameters: ["page": page,
                         "size": 10]
        ))
    }
    
    func searchStudio(
        conceptID: Int,
        region: RegionType?,
        popularity: RatingType?,
        price: PriceType?,
        page: Int,
        size: Int
    ) -> AnyPublisher<StudioSearchResultEntity, any Error> {
        requestObjectWithNetworkError(.search(
            conceptID: conceptID,
            parameters: ["region": region?.key ?? "ALL",
                         "page": page,
                         "size": 10]
        ))
    }
    
}


final class MockStudioService: BaseService<StudioAPI> { }
    
extension MockStudioService: StudioService {
    
    func getStudioConceptList() -> AnyPublisher<[ConceptEntity], any Error> {
        return Future { promise in
            let conceptList: [ConceptEntity] = [
                .init(id: 1, name: "FLASHY_GLOSSY", image: nil),
                .init(id: 2, name: "BLACK_BLUE_ACTOR", image: nil),
                .init(id: 3, name: "NATURAL_PHOTO", image: nil),
                .init(id: 4, name: "VIBRANT", image: nil),
                .init(id: 5, name: "WATERCOLOUR_GRAINY", image: nil),
                .init(id: 6, name: "CLEAR_DOLL_LIKE", image: nil)
            ]
            
            promise(.success(conceptList))
        }
        .eraseToAnyPublisher()
    }
    
    func getStudioList(
        conceptID: Int,
        page: Int,
        size: Int
    ) -> AnyPublisher<StudioSearchResultEntity, any Error> {
        return Future { promise in
            let studioList: StudioSearchResultEntity = .init(
                content: [
                    .init(id: 1, name: "아워유스", profileImage: nil, popularity: 4.8, portfolios: ["a", "b", "c"]),
                    .init(id: 2, name: "허쉬스튜디오", profileImage: nil, popularity: 4.8, portfolios: ["a", "b", "c", "d"]),
                    .init(id: 3, name: "레코디드", profileImage: nil, popularity: 4.8, portfolios: ["a", "b"]),
                    .init(id: 4, name: "셀리온", profileImage: nil, popularity: 4.8, portfolios: ["a", "b", "c", "d"]),
                    .init(id: 5, name: "리그라피", profileImage: nil, popularity: 4.8, portfolios: ["a", "b", "c", "d"]),
                ],
                pageable: .init(
                    pageNumber: 0,
                    pageSize: 10,
                    sort: .init(empty: true, unsorted: true, sorted: false),
                    offset: 0,
                    unpaged: false,
                    paged: true
                ),
                last: false,
                totalPages: 2,
                totalElements: 19,
                first: true,
                size: 10,
                number: 0,
                sort: .init(empty: true, unsorted: true, sorted: false),
                numberOfElements: 10,
                empty: false
            )
            
            promise(.success(studioList))
        }
        .eraseToAnyPublisher()
    }
    
    func searchStudio(
        conceptID: Int,
        region: RegionType?,
        popularity: RatingType?,
        price: PriceType?,
        page: Int,
        size: Int
    ) -> AnyPublisher<StudioSearchResultEntity, any Error> {
        return Future { promise in
            let studioList: StudioSearchResultEntity = .init(
                content: [
                    .init(id: 1, name: "아워유스", profileImage: nil, popularity: 4.8, portfolios: ["a", "b", "c"]),
                    .init(id: 2, name: "허쉬스튜디오", profileImage: nil, popularity: 4.8, portfolios: ["a", "b", "c", "d"]),
                    .init(id: 3, name: "레코디드", profileImage: nil, popularity: 4.8, portfolios: ["a", "b"]),
                    .init(id: 4, name: "셀리온", profileImage: nil, popularity: 4.8, portfolios: ["a", "b", "c", "d"]),
                    .init(id: 5, name: "리그라피", profileImage: nil, popularity: 4.8, portfolios: ["a", "b", "c", "d"]),
                ],
                pageable: .init(
                    pageNumber: 0,
                    pageSize: 10,
                    sort: .init(empty: true, unsorted: true, sorted: false),
                    offset: 0,
                    unpaged: false,
                    paged: true
                ),
                last: false,
                totalPages: 2,
                totalElements: 19,
                first: true,
                size: 10,
                number: 0,
                sort: .init(empty: true, unsorted: true, sorted: false),
                numberOfElements: 10,
                empty: false
            )
            
            promise(.success(studioList))
        }
        .eraseToAnyPublisher()
    }
    
}
