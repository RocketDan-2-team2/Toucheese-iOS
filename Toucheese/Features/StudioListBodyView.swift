//
//  FilterView.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//
//
//  StudioListBodyView.swift
//
//  Changed by 이선준 on 12/19/24.

import SwiftUI

struct StudioListBodyView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    @ObservedObject var studioViewModel: StudioViewModel
    
    @Binding var isShowingDrawer: Bool
    
    var body: some View {
        VStack(spacing: 0.0) {
            
            // Filter
            HStack {
                FilterButton(buttonType: .representation(hadFiltered: false)) {
                    navigationManager.present(
                        fullScreenCover:
                                .filterExpansionView(
                                    studioViewModel: studioViewModel
                                )
                    )
                }
                ForEach(FilterType.allCases, id: \.self) { filter in
                    FilterButton(buttonType: .filterType(title: filter.title)) {
                        navigationManager.present(
                            fullScreenCover:
                                    .filterExpansionView(
                                        studioViewModel: studioViewModel
                                    )
                        )
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16.0)
            .padding(.vertical, 8.0)
            
            // TODO: 필터 리스트 만들기
            
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
    }
}

#Preview {
    StudioListView(
        concept: .init(id: 1, name: "VIBRANT", image: nil)
    )
}
