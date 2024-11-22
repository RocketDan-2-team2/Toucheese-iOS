//
//  StudioListView.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI
import Combine

struct StudioListView: View {
    let studioService: StudioService = DefaultStudioService()
    let concept: ConceptEntity
    
    @State private var selectedFilterType: FilterType?
    
    @State private var selectedRegion: RegionType? = nil
    @State private var selectedRating: RatingType? = nil
    @State private var selectedPrice: PriceType? = nil
    @State private var currentPage: Int = 0
    
    @State private var studioList: [StudioEntity] = []

    @State private var bag = Set<AnyCancellable>()
    
    private var isHidden: Bool {
        selectedFilterType == nil
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            FilterView(
                selectedFilterType: $selectedFilterType,
                selectedRegion: $selectedRegion,
                selectedRating: $selectedRating,
                selectedPrice: $selectedPrice
            )
            .padding(.bottom, 10.0)
            .background {
                Color(.systemBackground)
                    .onTapGesture {
                        hideFilterExtensionView()
                    }
            }
            
            ZStack {
                ScrollView {
                    LazyVStack {
                        ForEach(studioList.indices, id: \.self) { index in
                            StudioListCell(
                                order: index + 1,
                                profileImage: studioList[index].profileImage ?? "",
                                name: studioList[index].name,
                                popularity: studioList[index].popularity ?? 0.0,
                                portfolios: studioList[index].portfolios
                            )
                            .onTapGesture {
                                print("셀 누름")
                            }
                        }
                        
                        Color(.systemBackground)
                            .frame(height: 5.0)
                            .onAppear {
                                print("페이지네이션 처리")
                            }
                    }
                    .ignoresSafeArea()
                    .background {
                        Color(.systemBackground)
                            .onTapGesture {
                                hideFilterExtensionView()
                            }
//                            .border(.black)
                    }
                }
                .refreshable {
                    
                }
                
                VStack {
                    FilterExpansionView(
                        selectedFilterType: $selectedFilterType,
                        selectedRegion: $selectedRegion,
                        selectedRating: $selectedRating,
                        selectedPrice: $selectedPrice
                    )
                    .opacity(isHidden ? 0 : 1)
                    .background(isHidden ? .orange.opacity(0) : .yellow)
                    
                    Spacer()
                }
            }
            .navigationTitle("검색")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Label("장바구니", systemImage: "cart")
                        .onTapGesture {
                            print("장바구니로 이동")
                            hideFilterExtensionView()
                        }
                }
            }
        }
        .onAppear {
            if !studioList.isEmpty { return }
            fetchStudioList()
        }
    }
    
    func hideFilterExtensionView() {
        print("배경 터치")
        selectedFilterType = nil
    }
    
    func fetchStudioList() {
        self.studioList = [
            .init(id: 9, name: "아워유스", profileImage: "", popularity: 4.8, portfolios: ["a", "b", "c"]),
            .init(id: 10, name: "허쉬스튜디오", profileImage: "", popularity: 4.3, portfolios: ["a", "b"]),
            .init(id: 11, name: "레코디드(홍대)", profileImage: "", popularity: 4.7, portfolios: ["a", "b", "c", "d"]),
            .init(id: 12, name: "레코디드(강남)", profileImage: "", popularity: 4.6, portfolios: ["a", "b", "c"])
        ]
//        studioService.searchStudio(
//            conceptID: concept.id,
//            region: .first,
//            popularity: .first,
//            price: .first,
//            page: currentPage,
//            size: 10
//        )
//        .sink { event in
//            switch event {
//            case .finished:
//                print("Concept: \(event)")
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        } receiveValue: { searchResult in
//            self.studioList = searchResult.content
//        }
//        .store(in: &bag)
    }
}

#Preview {
    NavigationStack {
        StudioListView(concept: .init(id: 1, name: "VIBRANT", image: nil))
    }
}
