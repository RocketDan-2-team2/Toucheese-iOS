//
//  ToucheeseApp.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct ToucheeseApp: App {
    @StateObject private var navigationManager = NavigationManager()
    
    init() {
        KakaoSDK.initSDK(appKey: ToucheeseEnv.kakaoAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.path) {
                IntroView()
                    .navigationDestination(for: ViewType.self) { view in
                        navigationManager.build(view)
                    }
                    .fullScreenCover(item: $navigationManager.fullScreenCover) { fullScreenCover in
                        navigationManager.build(fullScreenCover)
                    }
                    .transaction { transaction in
                        transaction.disablesAnimations = true
                    }
                    .onOpenURL { url in
                        if AuthApi.isKakaoTalkLoginUrl(url) {
                            _ = AuthController.handleOpenUrl(url: url)
                        }
                    }
            }
            .environmentObject(navigationManager)
        }
    }
}
