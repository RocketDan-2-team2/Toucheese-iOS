//
//  StudioReviewListView.swift
//  Toucheese
//
//  Created by SunJoon Lee on 11/28/24.
//

import SwiftUI

struct StudioReviewListView: View {
    
    let portfolios: [String]
    
    let gridItems: [GridItem] = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: gridItems) {
            ForEach(portfolios.indices, id: \.self) { index in
                AsyncImage(url: URL(string: portfolios[index])) { image in
                    Rectangle()
                        .fill(.placeholder)
                        .aspectRatio(1, contentMode: .fill)
                        .overlay {
                            image
                                .resizable()
                                .scaledToFit()
                        }
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .fill(.placeholder)
                            .aspectRatio(1, contentMode: .fill)
                        ProgressView()
                    }
                }
                .clipShape(Rectangle())
            }
        }
        .padding(5.0)
    }
}

#Preview {
    StudioReviewListView(portfolios: [
        "https://i.imgur.com/niY3nhv.jpeg",
        "https://i.imgur.com/niY3nhv.jpeg",
        "https://i.imgur.com/niY3nhv.jpeg",
        "https://i.imgur.com/niY3nhv.jpeg",
        "https://i.imgur.com/niY3nhv.jpeg",
    ])
}
