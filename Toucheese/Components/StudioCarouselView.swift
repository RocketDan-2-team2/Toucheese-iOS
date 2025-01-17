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
    
    init(urls: [String]) {
        if urls.isEmpty {
            self.urls = [""]
        } else {
            self.urls = urls
        }
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0.0) {
                ForEach(urls.indices, id: \.self) { index in
                    Color(.systemBackground)
                        .overlay {
                            AsyncImage(url: URL(string: urls[index])) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .brightness(-0.5)
                                default:
                                    Color.clear
                                        .skeleton(
                                            with: true,
                                            appearance: .gradient(
                                                color: Color(uiColor: .lightGray).opacity(0.5),
                                                background: Color(uiColor: .lightGray).opacity(0.3)
                                            ),
                                            shape: .rectangle
                                        )
                                }
                            }
                        }
                        .clipped()
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
                .padding(.bottom, 10.5)
                .padding(.trailing, 17.5)
        }
    }
    
    private var pageIndicator: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                if let pageId {
                    Text("\(pageId) / \(urls.count)")
                        .padding(.horizontal, 8.0)
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
