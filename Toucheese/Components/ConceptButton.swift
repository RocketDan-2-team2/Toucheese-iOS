//
//  ConceptButton.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI
import SkeletonUI

struct ConceptButton: View {
    let conceptImage: String
    let conceptName: String
    
    var tapAction: (() -> Void)?
    
    var body: some View {
        Button {
            tapAction?()
        } label: {
            VStack(spacing: 2) {
                Rectangle()
                    .fill(.placeholder)
                    .aspectRatio(9 / 11, contentMode: .fit)
                    .overlay {
                        AsyncImage(url: URL(string: conceptImage)) { image in
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
                                    shape: .rectangle
                                )
                        }
                    }
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(
                        color: .black.opacity(0.1),
                        radius: 8,
                        y: 2
                    )
                
                Text(conceptName)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.vertical, 4)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ConceptView(conceptList: [
        .init(id: 0, name: "a", image: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDA4MjFfNyAg%2FMDAxNzI0MTc4NDkxMjEw.yqR04Au7pctHZpPdFmoXxjmWvGdljNdkLDpLD4TxlRgg.D5bXtwnGoyY8Llc93kRlCTga0KqWRlaK3xu_WkBpU4cg.JPEG%2FIMG_1965.JPG&type=sc960_832"),
        .init(id: 1, name: "b", image: "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fimg.flayus.com%2Ffiles%2Fattach%2Fimages%2F425025%2F905%2F553%2F106%2Ffee411bdc98d0c301eb145f4ff1cf64a.jpg&type=sc960_832"),
        .init(id: 2, name: "c", image: "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDA4MjFfNyAg%2FMDAxNzI0MTc4NDkxMjEw.yqR04Au7pctHZpPdFmoXxjmWvGdljNdkLDpLD4TxlRgg.D5bXtwnGoyY8Llc93kRlCTga0KqWRlaK3xu_WkBpU4cg.JPEG%2FIMG_1965.JPG&type=sc960_832"),
        .init(id: 3, name: "d", image: "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fwww.fomos.kr%2Fcontents%2Fimages%2Fboard%2F2022%2F0816%2F1660616397238148.jpg&type=sc960_832"),
        .init(id: 4, name: "e", image: "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fimg.flayus.com%2Ffiles%2Fattach%2Fimages%2F425025%2F905%2F553%2F106%2Ffee411bdc98d0c301eb145f4ff1cf64a.jpg&type=sc960_832"),
        .init(id: 5, name: "f", image: "")
    ])
    .environmentObject(NavigationManager())
}
