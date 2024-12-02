//
//  StudioViewModel.swift
//  Toucheese
//
//  Created by 최주리 on 12/2/24.
//

import SwiftUI

import Combine

class StudioViewModel: ObservableObject {
    
    let studioService: StudioService = DefaultStudioService()
    
    @Published var concept: ConceptEntity = ConceptEntity(id: 0, name: "init", image: nil)
    @Published var selectedRegion: [RegionType] = []
    @Published var selectedRating: RatingType?
    @Published var selectedPrice: PriceType?
    
    @Published private(set) var studioList: [StudioEntity] = []
    
    private var bag = Set<AnyCancellable>()

    init() {
        Publishers.CombineLatest3(
            $selectedRegion,
            $selectedRating,
            $selectedPrice
        )
            .sink { [weak self] region, rating, price in
                self?.searchStudio(region: region, rating: rating, price: price)
            }
            .store(in: &bag)
    }
    
    //TODO: 페이지네이션 처리 하기
    
    func searchStudio(region: [RegionType], rating: RatingType?, price: PriceType?) {
        studioService.searchStudio(
            conceptID: concept.id,
            region: region,
            popularity: rating,
            price: price,
            page: 0,
            size: 10
        ).sink { event in
            switch event {
            case .finished:
                print("Event: \(event)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { searchResult in
            self.studioList = searchResult.content
        }
        .store(in: &bag)
    }
    
    func fetchStudioList() {
        studioService.getStudioList(
            conceptID: concept.id,
            page: 0,
            size: 10
        ).sink { event in
            switch event {
            case .finished:
                print("Event: \(event)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { searchResult in
            self.studioList = searchResult.content
        }
        .store(in: &bag)
    }
}
