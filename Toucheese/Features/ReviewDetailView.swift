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
    
    @State var review: Review
    @State var user: UserProfile
    
    @State private var isShowDetailImages: Bool = false
    @State private var selectedImageIndex: Int = 0
    
    @State private var bag = Set<AnyCancellable>()
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -90) {
                        ForEach(review.imageUrl.indices, id: \.self) { index in
                            CachedAsyncImage(
                                url: review.imageUrl[index],
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
                 \(review.description)
                 """)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal)
            .padding(.bottom, 100)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ThumbnailNavigationView(thumbnail: "\(user.profileImg)", title: "\(user.name)")
            }
        }
        .fullScreenCover(isPresented: $isShowDetailImages) {
            ReviewPhotoDetailView(imageList: review.imageUrl, selectedPhotoIndex: $selectedImageIndex, isShowDetailImages: $isShowDetailImages)
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
    }
}
