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
                    size: CGSize(width: 50, height: 50)
                )
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .strokeBorder(.gray)
                }
            } else {
                ProgressView()
                    .frame(width: 50, height: 50)
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
        .padding(.top)
    }
}

#Preview {
    ThumbnailNavigationView(thumbnail: "", title: "김레이")
}
