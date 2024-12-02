//
//  StudioDetailView.swift
//  Toucheese
//
//  Created by SunJoon Lee on 11/26/24.
//

import SwiftUI
import Combine

struct StudioDetailView: View {
    
//    let studioService: StudioService = DefaultStudioService()
    let studioService: StudioService = MockStudioService()
    
    @State private var tabSelection: Int = 0
    
    @State private var studioInfo: StudioInfo = .init(
        id: 0,
        name: "",
        profileImage: "",
        backgrounds: [],
        popularity: 0.0,
        dutyDate: "",
        address: "",
        description: ""
    )
    @State private var studioItems: [StudioProduct] = []
    @State private var studioReviews: [StudioReview] = []
    
    
    @State private var bag = Set<AnyCancellable>()
    
    let studioId: Int
    
    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: .sectionHeaders) {
                StudioCarouselView(urls: studioInfo.backgrounds)
                    .containerRelativeFrame(.vertical) { length, _ in
                        length * 0.3
                    }
                
                HStack {
                    VStack(alignment: .leading) {
                        Label(
                            "\(studioInfo.popularity, specifier: "%.1f")",
                            systemImage: "star"
                        )
                        Label(studioInfo.dutyDate, systemImage: "clock")
                        Label(studioInfo.address, systemImage: "map")
                    }
                    .padding(20.0)
                    .font(.system(size: 14.0))
                    Spacer()
                }
                
                Section {
                    switch tabSelection {
                    case 0:
                        StudioProductListView(
                            notice: studioInfo.description,
                            productList: studioItems
                        )
                    case 1:
                        StudioReviewListView(studioReviews: studioReviews)
                    default:
                        Text("아무것도 없음.")
                    }
                } header: {
                    VStack {
                        StudioDetailTab(tabSelection: $tabSelection)
                    }
                    .background(
                        Rectangle()
                            .fill(.background)
                    )
                }
            }
        }
        .onAppear{ fetchStudioDetail() }
        .refreshable { fetchStudioDetail() }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ThumbnailNavigationView(
                    thumbnail: studioInfo.profileImage,
                    title: studioInfo.name
                )
            }
        }
    }
    
    func fetchStudioDetail() {
        studioService.getStudioItems(studioID: studioId).sink { event in
            switch event {
            case .finished:
                print("Studio Detail with Items: \(event)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { studioDetailEntity in
            self.studioInfo = studioDetailEntity.translateToInfo()
            self.studioItems = studioDetailEntity.translateToFlatItems()
        }
        .store(in: &bag)
        
        studioService.getStudioReviews(studioID: studioId).sink { event in
            switch event {
            case .finished:
                print("Studio Detail with Reviews: \(event)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { studioDetailEntity in
            self.studioReviews = studioDetailEntity.translateToReviews()
        }
        .store(in: &bag)
    }
}

#Preview {
    NavigationStack {
        StudioDetailView(studioId: 1)
    }
}
