//
//  StudioNoticeView.swift
//  Toucheese
//
//  Created by 유지호 on 11/26/24.
//

import SwiftUI

struct StudioNoticeView: View {
    let notice: String
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "megaphone.fill")
                .resizable()
                .frame(width: 16, height: 14)
                .foregroundStyle(.orange)
            
            Text(notice)
                .font(.system(size: 14))
                .lineLimit(isExpanded ? nil : 2)
            
            Spacer()
            
            Image(systemName: isExpanded ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                .resizable()
                .foregroundStyle(.gray)
                .frame(width: 10, height: 6)
                .padding(4)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.placeholder.opacity(0.3))
        .clipShape(.rect(cornerRadius: 20))
        .onTapGesture {
            isExpanded.toggle()
        }
    }
}

#Preview {
    StudioNoticeView(notice: "저희 공운스튜디오는 주차장을 따로 운영하고 있습니다! 스튜디오 건물 오른 편으로 돌아 골목에 주차 가능합니다")
}
