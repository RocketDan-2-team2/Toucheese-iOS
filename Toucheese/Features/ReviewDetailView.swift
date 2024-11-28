//
//  ReviewDetailView.swift
//  Toucheese
//
//  Created by 최주리 on 11/26/24.
//

import SwiftUI

struct ReviewDetailView: View {
    
    let imageList: [String]
    let content: String
    
    var body: some View {
        
        VStack {
            
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    // LazyHStack으로 하니까 옆에 슬쩍 보이는 사진이 안나옴..
                    HStack(spacing: -90) {
                        ForEach(imageList, id: \.self) { imageString in
                            if let url = URL(string: imageString) {
                                CachedAsyncImage(
                                    url: url,
                                    size: CGSize(
                                        width: geometry.size.width * 0.8,
                                        height: 350
                                    )
                                )
                                .padding(.top, 50)
                                .padding(.horizontal, (geometry.size.width * 0.1))
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                
            }
            .frame(height: 420)
            
            Text("""
                 \(content)
                 """)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ThumbnailNavigationView(thumbnail: "", title: "김레이")
            }
        }
        
    }
}

#Preview {
    ReviewDetailView(imageList: [
        "https://i.imgur.com/niY3nhv.jpeg",
        "https://i.imgur.com/OG7dB2M.jpeg",
        "https://i.imgur.com/dOsihXY.jpeg",
        "https://i.imgur.com/Gd7fz7R.jpeg",
        "https://i.imgur.com/m7jMupR.jpeg",
        "https://i.imgur.com/iyD8YGk.jpeg",
    ],
                     content: """
                     공원스튜디오 다녀왔어요! 바디프로필 첫 촬영이라고 최대한 식단 관리하고 준비를 했는데도 사진이 잘 안나올까봐 엄청 걱정했지만 걱정도 잠시 작가님의 편안하고 자연스러운 분위기에 수십 장이 찍히는 줄도 모르고 웃고 떠들며 찍다보니 진짜 찐 웃음이 담긴 사진이 찍혀서 너무 자연스럽고 마음에 들더라구요 ㅠㅠㅠ
                     
                     공원스튜디오 진짜 짱 추천,,, 사장님도 왕예쁘고더 번창하세요 >_<~~~
                    """)
}
