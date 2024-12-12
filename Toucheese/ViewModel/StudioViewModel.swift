//
//  StudioViewModel.swift
//  Toucheese
//
//  Created by 최주리 on 12/2/24.
//

import SwiftUI

import Combine

final class StudioViewModel: ObservableObject {
    
    let studioService: StudioService = DefaultStudioService()
    
    @Published var concept: ConceptEntity = ConceptEntity(id: 0, name: "init", image: nil)
    @Published var selectedRegion: [RegionType] = [] {
        didSet {
            setDefaultPage()
            searchStudio()
        }
    }
    @Published var selectedRating: RatingType? {
        didSet {
            setDefaultPage()
            searchStudio()
        }
    }
    @Published var selectedPrice: PriceType? {
        didSet {
            setDefaultPage()
            searchStudio()
        }
    }
    
    @Published private(set) var studioList: [StudioEntity] = []
    
    private var bag = Set<AnyCancellable>()
    
    private var nextPage = 0
    private let pageSize = 10
    private var isLastPage = false
    
    // 처음 스튜디오 리스트 불러올 때, 혹은 필터가 바뀌었을때 사용됨
    func searchStudio() {
        
        if isLastPage { return }
        
        studioService.searchStudio(
            conceptID: concept.id,
            region: self.selectedRegion,
            popularity: self.selectedRating,
            price: self.selectedPrice,
            page: self.nextPage,
            size: self.pageSize
        ).sink { event in
            switch event {
            case .finished:
                print("Event: \(event)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] searchResult in
            self?.studioList += searchResult.content
            self?.toNextPage(searchResult: searchResult)
        }
        .store(in: &bag)
    }
    
    // 다음 페이지로 세팅
    private func toNextPage(searchResult: StudioSearchResultEntity) {
        if !searchResult.last {
            // 페이지 조절
            nextPage = searchResult.pageable.pageNumber + 1
        } else {
            // 마지막 페이지로 설정
            self.isLastPage = true
        }
    }
    
    // 페이징 초기화
    func setDefaultPage() {
        self.nextPage = 0
        self.studioList.removeAll()
        self.isLastPage = false
    }
}
