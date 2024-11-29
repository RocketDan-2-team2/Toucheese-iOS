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
    let studioBackgrounds: [String]
    let workTime: String
    let location: String
    
    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: .sectionHeaders) {
                StudioCarouselView(urls: studioBackgrounds)
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
                        StudioProductListView()
                    case 1:
                        StudioReviewListView(portfolios: studioEntity.portfolios)
                    default:
                        Text("아무것도 없음.")
                    }
                } header: {
                    VStack {
                        StudioDetailTab(tabSelection: $tabSelection)
                    }
                    .background(
                        Rectangle()
                            .fill(.background)
                    )
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ThumbnailNavigationView(
                    thumbnail: studioEntity.profileImage ?? "",
                    title: studioEntity.name
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        StudioDetailView(
            studioEntity: StudioEntity(
                id: 0,
                name: "공원스튜디오",
                profileImage: "https://i.imgur.com/niY3nhv.jpeg",
                popularity: nil,
                portfolios: [
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                    "https://i.imgur.com/niY3nhv.jpeg",
                ]
            ),
            studioBackgrounds: [
                "https://i.imgur.com/niY3nhv.jpeg",
//                "https://i.imgur.com/niY3nhv.jpeg",
//                "https://i.imgur.com/niY3nhv.jpeg",
            ],
            workTime: "월~금 10:10-19:00 / 매주 월 휴무",
            location: "서울특별시 서초구 강남대로 11-11"
        )
    }
}
