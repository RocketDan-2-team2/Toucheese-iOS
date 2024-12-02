//
//  ReviewDetailView.swift
//  Toucheese
//
//  Created by 최주리 on 11/26/24.
//

import SwiftUI
import Combine

struct ReviewDetailView: View {
    private let studioService: StudioService = DefaultStudioService()
    
    let reviewID: Int
    
    @State private var review: Review?
    @State private var user: UserProfile?
    
    @State var isShowDetailImages: Bool = false
    @State var selectedImageIndex: Int = 0
    
    @State private var bag = Set<AnyCancellable>()
    
    var imageList: [String] {
        review?.imageUrl ?? []
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -90) {
                        ForEach(imageList.indices, id: \.self) { index in
                            CachedAsyncImage(
                                url: imageList[index],
                                size: CGSize(
                                    width: geometry.size.width * 0.8,
                                    height: 350
                                )
                            )
                            .padding(.top, 50)
                            .padding(.horizontal, (geometry.size.width * 0.1))
                            .onTapGesture {
                                selectedImageIndex = index
                                isShowDetailImages = true
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                
            }
            
            Text("""
                 \(String(describing: review?.description ?? ""))
                 """)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal)
            .padding(.bottom, 100)
            
            Spacer()
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ThumbnailNavigationView(thumbnail: "\(user?.profileImg ?? "")", title: "\(user?.name ?? "김레이")")
            }
        }
        .fullScreenCover(isPresented: $isShowDetailImages) {
            ReviewPhotoDetailView(imageList: imageList, selectedPhotoIndex: $selectedImageIndex, isShowDetailImages: $isShowDetailImages)
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .onAppear {
            studioService.getReviewDetail(reviewID: reviewID)
                .sink { event in
                    switch event {
                    case .finished:
                        print("Event: \(event)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                } receiveValue: { review in
                    self.review = review.reviewDto
                    self.user = review.userProfileDto
                }
                .store(in: &bag)
        }
    }
}
