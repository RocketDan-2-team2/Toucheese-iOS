//
//  StudioReviewListView.swift
//  Toucheese
//
//  Created by SunJoon Lee on 11/28/24.
//

import SwiftUI

struct StudioReviewListView: View {
    
    let studioReviews: [StudioReview]
    
    let gridItems: [GridItem] = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: gridItems) {
            ForEach(studioReviews.indices, id: \.self) { index in
                Rectangle()
                    .fill(.placeholder)
                    .aspectRatio(1, contentMode: .fill)
                    .overlay {
                        CachedAsyncImage(
                            url: studioReviews[index].image,
                            size: CGSize(
                                width: CGFloat.infinity,
                                height: CGFloat.infinity
                            )
                        )
                    }
            }
        }
        .padding(5.0)
    }
}

#Preview {
    StudioReviewListView(studioReviews: [])
}
