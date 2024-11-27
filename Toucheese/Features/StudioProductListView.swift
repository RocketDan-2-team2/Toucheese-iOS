//
//  StudioProductListView.swift
//  Toucheese
//
//  Created by 유지호 on 11/27/24.
//

import SwiftUI

struct StudioProductListView: View {
    var body: some View {
        ScrollView {
            StudioNoticeView(notice: "저희 공운스튜디오는 주차장을 따로 운영하고 있습니다! 스튜디오 건물 오른 편으로 돌아 골목에 주차 가능합니다")
                .padding(.horizontal)
            
            LazyVStack(alignment: .leading) {
                Text("촬영 상품")
                    .font(.headline)
                
                ForEach(0...6, id: \.self) { _ in
                    StudioProductCell()
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    StudioProductListView()
}
