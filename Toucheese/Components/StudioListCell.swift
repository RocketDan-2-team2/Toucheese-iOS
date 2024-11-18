//
//  StudioListCell.swift
//  Toucheese
//
//  Created by woong on 11/15/24.
//

import SwiftUI

struct StudioListCell: View {
    
    var order: Int = 0
    
    var profileImage: String = "person.fill"
    
    var studioLabel: String = "dummy"
    
    var rate: Double = 0
    
    var portfolioImages: [String] = []
    
    @State var isBookmarked: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("\(order)")
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .padding(.horizontal)
                
                Image(systemName: profileImage)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
                
                VStack(alignment: .leading) {
                    Text(studioLabel)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    HStack {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundStyle(.yellow)
                            
                        Text("\(rate, specifier: "%.1f")")
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
                HStack {
                    ForEach(0..<5) { _ in
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    StudioListCell()
}
