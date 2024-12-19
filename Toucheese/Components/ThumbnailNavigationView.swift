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
            Circle()
                .fill(.placeholder)
                .overlay {
                    AsyncImage(url: URL(string: thumbnail)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.clear
                            .skeleton(
                                with: true,
                                appearance: .gradient(
                                    color: Color(uiColor: .lightGray).opacity(0.2)
                                ),
                                shape: .circle
                            )
                    }
                }
                .frame(width: 32, height: 32)
                .clipShape(.circle)
            
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.primary)
            
        }
        .padding(.vertical)
        .padding(.leading, -10)
        
    }
}

#Preview {
    ThumbnailNavigationView(thumbnail: "", title: "김레이")
}
