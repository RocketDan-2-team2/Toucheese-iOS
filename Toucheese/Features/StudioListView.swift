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
    
    let concept: ConceptEntity
    
    @StateObject private var studioViewModel: StudioViewModel = StudioViewModel()
    @State private var selectedFilterType: FilterType?
    
    private var isHidden: Bool {
        selectedFilterType == nil
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            FilterView(studioViewModel: studioViewModel, selectedFilterType: $selectedFilterType)
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
                        
                        Color(.systemBackground)
                            .frame(height: 5.0)
                            .onAppear {
                                if studioViewModel.studioList.isEmpty { return }
                                studioViewModel.searchStudio()
                            }
                    }
                    .ignoresSafeArea()
                    .background {
                        // 배경 눌러서 필터 뷰 올리기
                        Color(.systemBackground)
                            .onTapGesture {
                                hideFilterExtensionView()
                            }
                    }
                }
                .refreshable {
                    studioViewModel.setDefaultPage()
                    studioViewModel.searchStudio()
                }
                
                VStack {
                    FilterExpansionView(
                        studioViewModel: studioViewModel,
                        selectedFilterType: $selectedFilterType
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
        .onAppear {
            if !studioViewModel.studioList.isEmpty { return }
            
            studioViewModel.concept = concept
            studioViewModel.searchStudio()
        }
    }
    
    func hideFilterExtensionView() {
        print("배경 터치")
        selectedFilterType = nil
    }

}

#Preview {
    NavigationStack {
        StudioListView(concept: .init(id: 1, name: "VIBRANT", image: nil))
    }
}
