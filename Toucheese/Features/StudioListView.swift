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
        StudioListBodyView(
            studioViewModel: studioViewModel,
            isShowingDrawer: $isShowingDrawer
        )
        .onAppear {
            if !studioViewModel.studioList.isEmpty { return }
            
            studioViewModel.concept = concept
            studioViewModel.searchStudio()
        }
    }
}

#Preview {
    
    StudioListView(
        concept: .init(id: 1, name: "VIBRANT", image: nil)
    )
}
