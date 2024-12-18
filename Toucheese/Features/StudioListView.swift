//
//  StudioListView.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI
import Combine

struct StudioListView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    @StateObject private var studioViewModel: StudioViewModel = StudioViewModel()
    
    let concept: ConceptEntity
    
    var body: some View {
        VStack(spacing: 0.0) {
            
            // Filter
            HStack {
                FilterButton(buttonType: .representation(hadFiltered: false))
                ForEach(FilterType.allCases, id: \.self) { filter in
                    FilterButton(buttonType: .filterType(title: filter.title))
                }
                Spacer()
            }
            .padding(.horizontal, 16.0)
            .padding(.vertical, 8.0)
            
            if studioViewModel.studioList.isEmpty {
                VStack(spacing: 8.0) {
                    Spacer()
                    Text("조건에 맞는 스튜디오가 없습니다!")
                        .font(.system(size: 20.0))
                    Text("필터를 재설정해주세요.")
                        .font(.system(size: 14.0))
                        .foregroundStyle(.gray06)
                    Spacer()
                }
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(studioViewModel.studioList.indices, id: \.self) { index in
                            StudioListCell(
                                order: index + 1,
                                profileImage: studioViewModel.studioList[index].profileImage ?? "",
                                name: studioViewModel.studioList[index].name,
                                popularity: studioViewModel.studioList[index].popularity ?? 0.0,
                                portfolios: studioViewModel.studioList[index].portfolios
                            )
                            .onTapGesture {
                                let selectedStudio = studioViewModel.studioList[index]
                                navigationManager.push(
                                    .studioDetailView(studioId: selectedStudio.id)
                                )
                            }
                        }
                        
                        // Pagination 처리를 위한 Color
                        Color(.systemBackground)
                            .frame(height: 5.0)
                            .onAppear {
                                if studioViewModel.studioList.isEmpty { return }
                                studioViewModel.searchStudio()
                            }
                    }
                    .ignoresSafeArea()
                }
                .refreshable {
                    studioViewModel.setDefaultPage()
                    studioViewModel.searchStudio()
                }
            }
        }
        .onAppear {
            if !studioViewModel.studioList.isEmpty { return }
            
            studioViewModel.concept = concept
            studioViewModel.searchStudio()
        }
        .navigationTitle("검색")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Label("장바구니", systemImage: "cart")
                    .onTapGesture {
                        // TODO: 장바구니 네비게이션 처리
                        print("장바구니로 이동")
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        StudioListView(concept: .init(id: 1, name: "VIBRANT", image: nil))
    }
}
