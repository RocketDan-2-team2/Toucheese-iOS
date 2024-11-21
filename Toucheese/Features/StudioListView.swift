//
//  StudioListView.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI

struct StudioListView: View {
    let concept: ConceptEntity
    
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
    
    private var isHidden: Bool {
        selectedFilterType == nil
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            FilterView(
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
                        ForEach(studios.indices, id: \.self) { index in
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
                        
                        Color(.systemBackground)
                            .frame(height: 5.0)
                            .onAppear {
                                loadData()
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
                .refreshable {
                    loadData()
                }
                .onAppear {
                    loadData()
                }
                
                VStack {
                    FilterExpansionView(
                        selectedFilterType: $selectedFilterType,
                        selectedRegion: $selectedRegion,
                        selectedRating: $selectedRating,
                        selectedPrice: $selectedPrice
                    )
                    .opacity(isHidden ? 0 : 1)
                    .background(isHidden ? .orange.opacity(0) : .yellow)
                    
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
        selectedFilterType = nil
    }
    
    func loadData() {
        print("데이터 로드")
    }
}

#Preview {
    NavigationStack {
        StudioListView(concept: .init(id: 1, name: "VIBRANT", image: nil))
    }
}
