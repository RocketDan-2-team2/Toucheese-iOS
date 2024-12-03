//
//  ThumbnailNavigationView.swift
//  Toucheese
//
//  Created by 최주리 on 11/26/24.
//

import SwiftUI

struct ThumbnailNavigationView: View {
    @Environment(\.dismiss) private var dismiss
    let thumbnail: String
    let title: String
    
    var body: some View {
        
        HStack(spacing: 10) {
            CachedAsyncImage(url: thumbnail)
                .frame(width: 45, height: 45)
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .strokeBorder(.gray)
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
