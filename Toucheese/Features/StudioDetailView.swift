//
//  StudioDetailView.swift
//  Toucheese
//
//  Created by SunJoon Lee on 11/26/24.
//

import SwiftUI

struct StudioDetailView: View {
    
    @State private var tabSelection: Int = 0
    
    let studioEntity: StudioEntity
    let workTime: String
    let location: String
    
    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: .sectionHeaders) {
                StudioCarouselView(urls: [""])
                    .containerRelativeFrame(.vertical) { length, _ in
                        length * 0.3
                    }
                
                HStack {
                    VStack(alignment: .leading) {
                        Label(
                            "\(studioEntity.popularity ?? 0, specifier: "%.1f")",
                            systemImage: "star"
                        )
                        Label(workTime, systemImage: "clock")
                        Label(location, systemImage: "map")
                    }
                    .padding(20.0)
                    Spacer()
                }
                
                Section {
                    switch tabSelection {
                    case 0:
                        VStack {
                            ForEach(0..<50, id: \.self) { _ in
                                Text("가격")
                            }
                        }
                    case 1:
                        VStack {
                            ForEach(0..<50, id: \.self) { _ in
                                Text("리뷰")
                            }
                        }
                    default:
                        Text("아무것도 없음.")
                    }
                } header: {
                    StudioDetailTab(tabSelection: $tabSelection)
                }
            }
        }
        .navigationTitle(studioEntity.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        StudioDetailView(
            studioEntity: StudioEntity(
                id: 0,
                name: "공원스튜디오",
                profileImage: nil,
                popularity: nil,
                portfolios: []
            ),
            workTime: "월~금 10:10-19:00 / 매주 월 휴무",
            location: "서울특별시 서초구 강남대로 11-11"
        )
    }
}
