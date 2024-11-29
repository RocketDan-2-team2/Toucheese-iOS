//
//  CorouselView.swift
//  Toucheese
//
//  Created by SunJoon Lee on 11/27/24.
//

import SwiftUI

// TODO: 나중에 [스튜디오-리뷰-후기사진] 페이지에서도 쓰일 수 있도록 변경 예정

struct StudioCarouselView: View {
    
    let urls: [String]
    
    @State private var pageId: Int? = 1
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0.0) {
                ForEach(urls.indices, id: \.self) { index in
                    AsyncImage(url: URL(string: urls[index])) { image in
                        Color(.systemBackground)
                            .overlay {
                                image
                                    .resizable()
                                    .scaledToFit()
                            }
                            .brightness(-0.5)
                    } placeholder: {
                        ZStack {
                            Color(.black)
                                .opacity(0.6)
                            ProgressView()
                        }
                    }
                    .id(index + 1)
                    .containerRelativeFrame(.horizontal)
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollPosition(id: $pageId)
        .scrollTargetBehavior(.viewAligned)
        .overlay {
            pageIndicator
                .padding(10.0)
        }
    }
    
    private var pageIndicator: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                if let pageId {
                    Text("\(pageId) / \(urls.count)")
                        .padding(.horizontal, 20.0)
                        .padding(.vertical, 2.0)
                        .foregroundStyle(.background)
                        .background {
                            RoundedRectangle(cornerRadius: 20.0)
                                .opacity(0.7)
                        }
                }
            }
        }
    }
}

#Preview {
    StudioCarouselView(
        urls: [
            "https://i.imgur.com/niY3nhv.jpeg",
            "https://i.imgur.com/niY3nhv.jpeg",
            "https://i.imgur.com/niY3nhv.jpeg",
            "https://i.imgur.com/niY3nhv.jpeg",
            "https://i.imgur.com/niY3nhv.jpeg",
        ]
    )
}
