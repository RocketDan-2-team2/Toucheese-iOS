//
//  StudioDetailView.swift
//  Toucheese
//
//  Created by SunJoon Lee on 11/26/24.
//

import SwiftUI
import Combine

struct StudioDetailView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let studioService: StudioService = DefaultStudioService()
    
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
    
    @State private var bag = Set<AnyCancellable>()
    
    @State private var onLoading: Bool = true
    
    @State private var hoursRawData: [StudioHoursEntity] = []
    
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
                        appearance: .gradient(
                            color: Color(uiColor: .lightGray).opacity(0.5),
                            background: Color(uiColor: .lightGray).opacity(0.3)
                        ),
                        shape: .rectangle,
                        scales: [0: 0.75]
                    )
                    .padding(.bottom, 8.0)
                    
                    Label(
                        "\(studioInfo.popularity, specifier: "%.1f")",
                        systemImage: "star.fill"
                    )
                    .skeleton(
                        with: onLoading,
                        appearance: .gradient(
                            color: Color(uiColor: .lightGray).opacity(0.5),
                            background: Color(uiColor: .lightGray).opacity(0.3)
                        ),
                        shape: .rectangle,
                        scales: [0: 0.4]
                    )
                    
                    Label(studioInfo.dutyDate, systemImage: "clock")
                        .skeleton(
                            with: onLoading,
                            appearance: .gradient(
                                color: Color(uiColor: .lightGray).opacity(0.5),
                                background: Color(uiColor: .lightGray).opacity(0.3)
                            ),
                            shape: .rectangle,
                            scales: [0: 0.7]
                        )
                    
                    Label(studioInfo.address, systemImage: "map")
                        .skeleton(
                            with: onLoading,
                            appearance: .gradient(
                                color: Color(uiColor: .lightGray).opacity(0.5),
                                background: Color(uiColor: .lightGray).opacity(0.3)
                            ),
                            shape: .rectangle,
                            scales: [0: 1.0]
                        )
                }
                .padding(20.0)
                .font(.system(size: 14.0))
                
                Rectangle()
                    .fill(Color(red: 250 / 255, green: 250 / 255, blue: 250 / 255))
                    .frame(height: 8.0)
                
                Section {
                    switch tabSelection {
                    case .price:
                        studioProductListView
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
        .task {
            fetchStudioDetail()
            fetchStudioHours()
        }
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ThumbnailNameView(
                    thumbnail: studioInfo.profileImage,
                    title: studioInfo.name
                )
                .padding(.leading, -10)
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
    }
    
    private var studioProductListView: some View {
        ScrollView {
            StudioNoticeView(notice: studioInfo.description)
                .padding(.horizontal)
            
            LazyVStack(alignment: .leading) {
                Text("촬영 상품")
                    .font(.headline)
                    .padding(.horizontal)
                
                ForEach(studioItems) { product in
                    Button {
                        fetchStudioProductDetil(id: product.id)
                    } label: {
                        StudioProductCell(product: product)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.vertical, 8)
        }
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
                        fetchReviewDetail(id: studioReviews[index].id)
                    }
            }
        }
        .padding(5.0)
    }
    
    //MARK: - Network 
    
    func fetchStudioProductDetil(id: Int) {
        studioService.getStudioProductDetail(productID: id)
            .sink { event in
                switch event {
                case .finished:
                    print("ProductDetail: \(event)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { studioProduct in
                navigationManager.push(
                    .studioProductDetailView(
                        studio: studioInfo,
                        product: studioProduct.translate(),
                        hoursRawData: hoursRawData
                    )
                )
            }
            .store(in: &bag)
    }
    
    func fetchReviewDetail(id: Int) {
        studioService.getReviewDetail(reviewID: id)
            .sink { event in
                switch event {
                case .finished:
                    print("Event: \(event)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { review in
                navigationManager.push(
                    .reviewDetailView(
                        review: review.reviewDto,
                        user: review.userProfileDto
                    )
                )
            }
            .store(in: &bag)
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
    
    private func fetchStudioHours() {
        studioService.getStudioHours(studioID: studioId)
            .sink { event in
                switch event {
                case .finished:
                    print("Event: \(event)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { data in
                hoursRawData = data
            }
            .store(in: &bag)

    }
}

#Preview {
    NavigationStack {
        StudioDetailView(studioId: 1)
    }
}

