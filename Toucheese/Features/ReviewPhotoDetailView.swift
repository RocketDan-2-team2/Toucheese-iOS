//
//  ReviewPhotoDetailView.swift
//  Toucheese
//
//  Created by 최주리 on 11/29/24.
//

import SwiftUI

struct ReviewPhotoDetailView: View {
    
    let imageList: [String]
    // 받아오는 Index
    @Binding var selectedPhotoIndex: Int
    @Binding var isShowDetailImages: Bool
    
    init(imageList: [String], selectedPhotoIndex: Binding<Int>, isShowDetailImages: Binding<Bool>) {
        self.imageList = imageList
        self._selectedPhotoIndex = selectedPhotoIndex
        self._isShowDetailImages = isShowDetailImages
        
        print("init index: \(selectedPhotoIndex)")
    }
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(imageList.indices, id: \.self) { index in
                            CachedAsyncImage(
                                url: imageList[index],
                                size: CGSize(
                                    width: UIScreen.main.bounds.width,
                                    height: 500
                                )
                            )
                            .id(index)
                        }
                    }
                }
                .onAppear {
                    print("onapear index: \(selectedPhotoIndex)")
                    proxy.scrollTo(selectedPhotoIndex, anchor: .center)
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            
            //TODO: 인디케이터
            Spacer()
            
        }
        .background {
            Color(.black)
                .onTapGesture {
                    isShowDetailImages = false
                }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}
