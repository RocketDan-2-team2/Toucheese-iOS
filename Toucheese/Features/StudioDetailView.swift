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
    
    @State private var tabSelection: StudioDetailTabType = .price
    
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
    @State private var studioItems: [StudioItem] = []
    @State private var studioReviews: [StudioReview] = []
    @State private var review: ReviewEntity?
    @State private var selectedProduct: StudioProduct?
    
    @State private var bag = Set<AnyCancellable>()
    
    @State private var onLoading: Bool = true
    
    let studioId: Int
    let gridItems: [GridItem] = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    init(studioId: Int) {
        self.studioId = studioId
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: .sectionHeaders) {
                StudioCarouselView(urls: studioInfo.backgrounds)
                    .containerRelativeFrame(.vertical) { length, _ in
                        length * 0.3
                    }
                
                VStack(alignment: .leading, spacing: 4.0) {
                    HStack {
                        Text(studioInfo.name)
                            .font(.system(size: 18.0))
                            .bold()
                        Spacer()
                    }
                    .skeleton(
                        with: onLoading,
                        size: CGSize(width: .infinity, height: 22.0),
                        appearance: .gradient(
                            color: Color(uiColor: .lightGray).opacity(0.5),
                            background: Color(uiColor: .lightGray).opacity(0.3)
                        ),
                        shape: .rectangle
                    )
                    .padding(.bottom, 8.0)
                    
                    Label(
                        "\(studioInfo.popularity, specifier: "%.1f")",
                        systemImage: "star.fill"
                    )
                    .skeleton(
                        with: onLoading,
                        size: CGSize(width: 130.0, height: 16.0),
                        appearance: .gradient(
                            color: Color(uiColor: .lightGray).opacity(0.5),
                            background: Color(uiColor: .lightGray).opacity(0.3)
                        ),
                        shape: .rectangle
                    )
                    
                    Label(studioInfo.dutyDate, systemImage: "clock")
                        .skeleton(
                            with: onLoading,
                            size: CGSize(width: .infinity, height: 16.0),
                            appearance: .gradient(
                                color: Color(uiColor: .lightGray).opacity(0.5),
                                background: Color(uiColor: .lightGray).opacity(0.3)
                            ),
                            shape: .rectangle
                        )
                    
                    Label(studioInfo.address, systemImage: "map")
                        .skeleton(
                            with: onLoading,
                            size: CGSize(width: .infinity, height: 16.0),
                            appearance: .gradient(
                                color: Color(uiColor: .lightGray).opacity(0.5),
                                background: Color(uiColor: .lightGray).opacity(0.3)
                            ),
                            shape: .rectangle
                        )
                }
                .padding(20.0)
                .font(.system(size: 14.0))
                
                Rectangle()
                    .fill(Color(red: 0.9804, green: 0.9804, blue: 0.9804))
                    .frame(height: 8.0)
                
                Section {
                    switch tabSelection {
                    case .price:
                        StudioProductListView(
                            notice: studioInfo.description,
                            productList: studioItems,
                            selectedProduct: $selectedProduct
                        )
                    case .review:
                        studioReviewListView
                    }
                } header: {
                    StudioDetailTabBar(tabSelection: $tabSelection)
                        .padding(8.0)
                        .background(.background)
                }
            }
        }
        .task { fetchStudioDetail() }
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ThumbnailNavigationView(
                    thumbnail: studioInfo.profileImage,
                    title: studioInfo.name
                )
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 20.0) {
                    Label("share", systemImage: "square.and.arrow.up")
                    Label("heart",
                          // TODO: 유저가 "좋아요" 눌렀는지에 따라 다르게 변경
                          systemImage: "heart"
                    )
                }
            }
        }
        .navigationDestination(item: $selectedProduct) { product in
            StudioProductDetailView(studio: studioInfo, product: product)
        }
        .navigationDestination(item: $review) { review in
            ReviewDetailView(review: review.reviewDto, user: review.userProfileDto)
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
            self.studioItems = studioDetailEntity.translateToItems()
            self.onLoading = false
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
    
    private var studioReviewListView: some View {
        LazyVGrid(columns: gridItems) {
            ForEach(studioReviews.indices, id: \.self) { index in
                Rectangle()
                    .fill(.placeholder)
                    .aspectRatio(1, contentMode: .fill)
                    .overlay {
                        CachedAsyncImage(url: studioReviews[index].image)
                    }
                    .onTapGesture {
                        studioService.getReviewDetail(reviewID: studioReviews[index].id)
                            .sink { event in
                                switch event {
                                case .finished:
                                    print("Event: \(event)")
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            } receiveValue: { review in
                                self.review = review
                            }
                            .store(in: &bag)
                    }
            }
        }
        .padding(5.0)
    }
}

#Preview {
    NavigationStack {
        StudioDetailView(studioId: 1)
    }
}
