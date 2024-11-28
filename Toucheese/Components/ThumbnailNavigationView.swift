//
//  ThumbnailNavigationView.swift
//  Toucheese
//
//  Created by 최주리 on 11/26/24.
//

import SwiftUI

struct ThumbnailNavigationView: View {
    
    let thumbnail: String
    let title: String
    
    var body: some View {
        
        HStack(spacing: 10) {
            Button(action: {
                print("back!")
            }) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            }
            if let url = URL(string: thumbnail) {
                CachedAsyncImage(
                    url: url,
                    size: CGSize(width: 45, height: 45)
                )
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .strokeBorder(.gray)
                }
            } else {
                ProgressView()
                    .frame(width: 45, height: 45)
                    .background(.gray.opacity(0.3))
                    .clipShape(.circle)
                    .overlay {
                        Circle()
                            .strokeBorder(.gray)
                    }
            }
            
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)
            
        }
        .padding(.vertical)
    }
}

#Preview {
    ThumbnailNavigationView(thumbnail: "", title: "김레이")
}
