//
//  ToucheeseTabView.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

struct ToucheeseTabView: View {
    
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some View {
        
        TabView(selection: $navigationManager.selectedTab) {
            NavigationStack(path: $navigationManager.homePath) {
                IntroView()
                    .navigationDestination(for: ViewType.self) { view in
                        navigationManager.build(view)
                    }
            }
            .tabItem { Label("홈", systemImage: "house") }
            .tag(TabViewType.home)

            NavigationStack(path: $navigationManager.reservationPath) {
                ReservationListView()
                    .navigationDestination(for: ViewType.self) { view in
                        navigationManager.build(view)
                    }
            }
            .tabItem { Label("예약일정", systemImage: "calendar") } 
            .tag(TabViewType.reservation)
        }
        .environmentObject(navigationManager)
        .fullScreenCover(item: $navigationManager.fullScreenCover) { fullScreenCover in
            navigationManager.build(fullScreenCover)
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        
    }
}

#Preview {
    ToucheeseTabView()
}
