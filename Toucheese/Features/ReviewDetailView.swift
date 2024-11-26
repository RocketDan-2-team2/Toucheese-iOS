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
        
        //TODO: 네비게이션 부분 만들기
        
        VStack {
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(imageList, id: \.self) { imageString in
                        AsyncImage(url: URL(string: imageString)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            
            Text(content)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
        }
        
    }
}

#Preview {
    ReviewDetailView(imageList: [], content: "공원스튜디오 다녀왔어요! 바디프로필 첫 촬영이라고 최대한 식단 관리하고 준비를 했는데도 사진이 잘 안나올까봐 엄청 걱정했지만 걱정도 잠시 작가님의 편안하고 자연스러운 분위기에 수십 장이 찍히는 줄도 모르고 웃고 떠들며 찍다보니 진짜 찐 웃음이 담긴 사진이 찍혀서 너무 자연스럽고 마음에 들더라구요 ㅠㅠㅠ\n\n공원스튜디오 진짜 짱 추천,,, 사장님도 왕예쁘고더 번창하세요 >_<~~~")
}
