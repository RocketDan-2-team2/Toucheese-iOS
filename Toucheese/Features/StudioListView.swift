//
//  StudioListView.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI
import Combine

struct StudioListView: View {
    
    @StateObject private var studioViewModel: StudioViewModel = StudioViewModel()
    
    @State private var isShowingDrawer: Bool = false
    
    let concept: ConceptEntity
    
    var body: some View {
        DrawerView(isShowingDrawer: $isShowingDrawer) {
            HStack {
                StudioListBodyView(
                    studioViewModel: studioViewModel,
                    isShowingDrawer: $isShowingDrawer
                )
            }
        } drawerContent: {
            FilterExpansionView(
                studioViewModel: studioViewModel,
                isShowingDrawer: $isShowingDrawer
            )
        }
        .onAppear {
            if !studioViewModel.studioList.isEmpty { return }
            
            studioViewModel.concept = concept
            studioViewModel.searchStudio()
        }
        // FIXME: NavigationStack으로 덮으면, GeometryReader의 Offset이 다 변경되어서 문제가 생김
        // 커스텀 네비게이션바 사용해야할듯함        
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
    StudioListView(
        concept: .init(id: 1, name: "VIBRANT", image: nil)
    )
}
