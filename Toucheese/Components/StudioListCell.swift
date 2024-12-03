//
//  StudioListCell.swift
//  Toucheese
//
//  Created by woong on 11/15/24.
//

import SwiftUI

struct StudioListCell: View {
    let order: Int
    let profileImage: String
    let name: String
    let popularity: Float
    let portfolios: [String]
    
    @State private var isBookmarked: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("\(order)")
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .padding(.horizontal)
                
                AsyncImage(url: URL(string: profileImage)) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .background(.gray.opacity(0.3))
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .strokeBorder(.gray)
                }
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    HStack {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundStyle(.yellow)
                            
                        Text("\(popularity, specifier: "%.1f")")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer()
                
                Button {
                    isBookmarked.toggle()
                } label: {
                    Label("Bookmark", systemImage: isBookmarked ? "bookmark.fill" : "bookmark")
                        .labelStyle(.iconOnly)
                        .foregroundStyle(.primary)
                }
                .padding(.horizontal)
            }
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(portfolios, id: \.self) { portfolio in
                        AsyncImage(url: URL(string: portfolio)) { image in
                            image.resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 147, height: 147)
                        .background(.gray.opacity(0.3))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
        }
        .background {
            Rectangle()
                .fill(.background)
        }
        .padding(.vertical)
    }
}

#Preview {
    StudioListCell(
        order: 1,
        profileImage: "",
        name: "퓨어&플라워",
        popularity: 4.8,
        portfolios: ["a", "b", "c"]
    )
}
