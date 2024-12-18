//
//  StudioListCell.swift
//  Toucheese
//
//  Created by woong on 11/15/24.
//

import SwiftUI
import SkeletonUI

struct StudioListCell: View {
    let order: Int
    let profileImage: String
    let name: String
    let popularity: Float
    let portfolios: [String]
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                AsyncImage(url: URL(string: profileImage)) { image in
                    image.resizable()
                        .scaledToFit()
                        .clipShape(.circle)
                } placeholder: {
                    Circle()
                        .fill(.clear)
                        .skeleton(
                            with: true,
                            appearance: .gradient(
                                color: Color(uiColor: .lightGray).opacity(0.2)
                            ),
                            shape: .circle
                        )
                }
                .frame(width: 32, height: 32)
                .background {
                    Circle()
                        .fill(.placeholder)
                }
                
                Text(name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        
                    Text("\(popularity, specifier: "%.1f")")
                        .foregroundStyle(.gray)
                }
                .font(.system(size: 12, weight: .medium))
            }
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 6) {
                    ForEach(portfolios, id: \.self) { portfolio in
                        AsyncImage(url: URL(string: portfolio)) { image in
                            image.resizable()
                                .scaledToFill()
                        } placeholder: {
                            Rectangle()
                                .fill(.clear)
                                .skeleton(
                                    with: true,
                                    appearance: .gradient(
                                        color: Color(uiColor: .lightGray).opacity(0.2)
                                    ),
                                    shape: .rectangle
                                )
                        }
                        .frame(width: 100, height: 140)
                        .background(.placeholder)
                        .clipShape(.rect(cornerRadius: 20))
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(.white)
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 8
                )
        }
    }
}

#Preview {
    StudioListCell(
        order: 1,
        profileImage: "",
        name: "퓨어&플라워",
        popularity: 4.8,
        portfolios:[
            "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDA4MjFfNyAg%2FMDAxNzI0MTc4NDkxMjEw.yqR04Au7pctHZpPdFmoXxjmWvGdljNdkLDpLD4TxlRgg.D5bXtwnGoyY8Llc93kRlCTga0KqWRlaK3xu_WkBpU4cg.JPEG%2FIMG_1965.JPG&type=sc960_832",
            "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fimg.flayus.com%2Ffiles%2Fattach%2Fimages%2F425025%2F905%2F553%2F106%2Ffee411bdc98d0c301eb145f4ff1cf64a.jpg&type=sc960_832",
            "https://postfiles.pstatic.net/MjAyNDAxMTFfMTAw/MDAxNzA0OTAyMzM0Njcy.BtsOvTb73MR5ekJNKs8Enaz1kAYdvR8X8rOoPGFJjvwg.92FqJLcknfrD576kp3pKpexCoJO4Xh8SWEbaLENARaIg.JPEG.godzilla1998/GBJyQ8ibAAAlgc5.jpg?type=w773",
            "d"
        ]
    )
    .frame(width: 361, height: 220)
}
