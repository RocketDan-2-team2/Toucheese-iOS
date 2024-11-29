//
//  CachedAsyncImage.swift
//  Toucheese
//
//  Created by 최주리 on 11/28/24.
//

import SwiftUI

struct CachedAsyncImage: View {
    
    let url: String
    let size: CGSize
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: size.width, height: size.height)
            
        } else {
            ProgressView()
                .frame(width: size.width, height: size.height)
                .onAppear {
                    loadImage()
                }
        }
        
    }
    
    private func loadImage() {
        
        // 캐싱되어있다면 이미지 return
        guard let url = URL(string: url) else { return }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)),
           let cachedImage = UIImage(data: cachedResponse.data) {
            self.image = cachedImage
            return
        }
        
        // 없다면 이미지 로드
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let response = response,
                  error == nil,
                  let image = UIImage(data: data) else { return }
            
            // 캐싱
            let cachedData = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedData, for: URLRequest(url: url))
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }

}
