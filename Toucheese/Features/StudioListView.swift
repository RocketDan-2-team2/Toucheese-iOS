//
//  StudioListView.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI

struct StudioListView: View {
    
//    let concept: String
//    let concept: String = ""
    
    @State private var isChanged: Bool = false
    @State private var isHidden: Bool = true
    
    @State private var selectedFilterType: FilterType?
    
    @State private var selectedRegion: RegionType? = nil
    @State private var selectedRating: RatingType? = nil
    @State private var selectedPrice: PriceType? = nil
    
    private let studios = [
        Studio(),
        Studio(),
        Studio(),
        Studio(),
        Studio(),
        Studio(),
        Studio(),
        Studio(),
        Studio(),
        Studio(),
    ]
    
    var body: some View {
        VStack(spacing: 0.0) {
            FilterView(
                isChanged: $isChanged,
                isHidden: $isHidden,
                selectedFilterType: $selectedFilterType,
                selectedRegion: $selectedRegion,
                selectedRating: $selectedRating,
                selectedPrice: $selectedPrice
            )
            .padding(.bottom, 10.0)
            .background {
                Color(.systemBackground)
                    .onTapGesture {
                        hideFilterExtensionView()
                    }
            }
            
            ZStack {
                ScrollView {
                    LazyVStack {
                        ForEach(0..<studios.count, id: \.self) { index in
                            StudioListCell(
                                order: index + 1,
                                profileImage: studios[index].profileImage,
                                studioLabel: studios[index].studioLabel,
                                rate: studios[index].rate,
                                portfolioImages: studios[index].portfolioImages
                            )
                            .onTapGesture {
                                print("셀 누름")
                            }
                        }
                    }
                    .ignoresSafeArea()
                    .background {
                        Color(.systemBackground)
                            .onTapGesture {
                                hideFilterExtensionView()
                            }
//                            .border(.black)
                    }
                }
                
                
                
                VStack {
                    FilterExpansionView(
                        isChanged: $isChanged,
                        isHidden: $isHidden,
                        selectedFilterType: $selectedFilterType,
                        selectedRegion: $selectedRegion,
                        selectedRating: $selectedRating,
                        selectedPrice: $selectedPrice
                    )
                    
                    Spacer()
                }
            }
            .navigationTitle("검색")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Label("장바구니", systemImage: "cart")
                        .onTapGesture {
                            print("장바구니로 이동")
                            hideFilterExtensionView()
                        }
                }
            }
        }
    }
    
    private struct Studio {
        let profileImage: String = "person.fill"
        let studioLabel: String = "dummy"
        let rate: Double = 0
        let portfolioImages: [String] = []
    }
    
    func hideFilterExtensionView() {
        print("배경 터치")
        isHidden = true
        selectedFilterType = nil
    }
}

#Preview {
    NavigationStack {
        StudioListView()
    }
}
