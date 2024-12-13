//
//  ToucheeseApp.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI

@main
struct ToucheeseApp: App {
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.path) {
                IntroView()
                    .navigationDestination(for: ViewType.self) { view in
                        navigationManager.build(view)
                    }
            }
            .environmentObject(navigationManager)
        }
    }
}
