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
    
    @State var isShowDetailImages: Bool = false
    @State var selectedImageIndex: Int = 0

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -90) {
                        ForEach(imageList.indices, id: \.self) { index in
                            CachedAsyncImage(
                                url: imageList[index],
                                size: CGSize(
                                    width: geometry.size.width * 0.8,
                                    height: 350
                                )
                            )
                            .padding(.top, 50)
                            .padding(.horizontal, (geometry.size.width * 0.1))
                            
                            // fullScreenCover보다 onTapGesture가 먼저 실행되는데
                            // ReviewPhotoDetailView의 생성자 매개변수로 변경되기 전 selectedImageIndex 값이 들어가는 이슈
                            //
                            
                            // index를 바꾸는 부분과 isPresent의 bool 변수를 true로 변경하는 부분이 호출 순서대로 코드가 실행되지 않음!!!
                            // index가 바뀌기 전에 true로 바뀌어 변경되기 전인 초기값으로 modal view가 그려짐
                            // -> index가 변경되는 값을 감지하여 onChange로 bool 변수를 변경하는 코드로 수정
                            // 여기서 의문인 점은 두번째 탭 동작부터는 제대로 작동한다는 것임...
                            // 왜일까나. . . . . . .
                        
                            
                            // detail view에서 변수를 실질적으로 사용하지 않아서 selectedIMageIndex는 변경되지만 _selectedImageIndex의 값이 변경되지 않음(State값?? )
                            
                            // 두번째부터 잘되는 이유는... reviewphotodetailview에서 selectedImageIndex 값을 사용했기 때문에 뷰가 렌더링이 됨..
                            
                            // 그냥 바인딩을 쓰는게 좋을듯 -> 어쨌든 인덱스가 변경된 걸 뷰가 알았을 때 스유가 다시 그려주는데 그러기 위해서는 걍 편하게 binding을 하는게 좋을 듯 함
                            // binding의 역할을 하나 더 배웟다,,,
                            // 변수가 뷰에 그려지지 않아도 상태추적을 할 수 있다는 것?
                            
                            // state 변수는 바인딩으로 계속 연결하면 안됨?? => 성능 이슈 잇나??
                            // 흠...
                            
                            .onTapGesture {
                                selectedImageIndex = index
                                isShowDetailImages = true
                            }
                        }
                    }
                    .scrollTargetLayout()
//                    Text("\(selectedImageIndex)")
                }
                .scrollTargetBehavior(.viewAligned)
                
            }
            
            Text("""
                 \(content)
                 """)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal)
            .padding(.bottom, 100)
            
            Spacer()
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ThumbnailNavigationView(thumbnail: "", title: "김레이")
            }
        }
        .fullScreenCover(isPresented: $isShowDetailImages) {
            ReviewPhotoDetailView(imageList: imageList, selectedPhotoIndex: $selectedImageIndex, isShowDetailImages: $isShowDetailImages)
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
//        .onChange(of: selectedImageIndex, {
//            isShowDetailImages = true
//        })
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
