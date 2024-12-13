//
//  ReviewDetailView.swift
//  Toucheese
//
//  Created by 최주리 on 11/26/24.
//

import SwiftUI
import Combine

struct ReviewDetailView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    private let studioService: StudioService = DefaultStudioService()
    
    @State private var review: Review
    @State private var user: UserProfile
    
    @State private var selectedImageIndex: Int = 0
    
    @State private var bag = Set<AnyCancellable>()
    
    init(review: Review, user: UserProfile) {
        self.review = review
        self.user = user
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -90) {
                        ForEach(review.imageUrl.indices, id: \.self) { index in
                            CachedAsyncImage(url: review.imageUrl[index])
                            .frame(width: geometry.size.width * 0.8, height: 350)
                            .padding(.top, 50)
                            .padding(.horizontal, (geometry.size.width * 0.1))
                            .onTapGesture {
                                selectedImageIndex = index
                                navigationManager.present(
                                    fullScreenCover:
                                            .reviewPhotoDetailView(
                                                imageList: review.imageUrl,
                                                selectedPhotoIndex: $selectedImageIndex
                                            )
                                )
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
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ThumbnailNavigationView(thumbnail: "\(user.profileImg)", title: "\(user.name)")
            }
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
    }
}
