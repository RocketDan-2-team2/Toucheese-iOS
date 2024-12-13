//
//  ReviewPhotoDetailView.swift
//  Toucheese
//
//  Created by 최주리 on 11/29/24.
//

import SwiftUI

struct ReviewPhotoDetailView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let imageList: [String]
    @Binding var selectedPhotoIndex: Int

    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Image(systemName: "xmark")
                    .foregroundStyle(.white)
                    .font(.system(size: 20))
                    .padding()
                    .onTapGesture {
                        navigationManager.dismiss()
                    }
            }
            .padding(.top, 60)
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(imageList.indices, id: \.self) { index in
                            CachedAsyncImage(url: imageList[index])
                            .frame(width: UIScreen.main.bounds.width,height: 500)
                            .id(index)
                        }
                    }
                }
                .onAppear {
                    proxy.scrollTo(selectedPhotoIndex, anchor: .center)
                }
                .scrollTargetLayout()
            }
            .padding(.vertical, 50)
            .padding(.top, 30)
            .scrollTargetBehavior(.viewAligned)
            
//            HStack {
//                ForEach(0..<imageList.count) { num in
//                    Image(systemName: "circle.fill")
//                        .font(.system(size: 10))
//                        .foregroundStyle(selectedPhotoIndex == num ? .blue : Color(uiColor: .systemGray4))
//                }
//            }
//            .padding()
//            
            Spacer()
            
        }
        .background {
            Color(.black)
                .onTapGesture {
                    navigationManager.dismiss()
                }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}
