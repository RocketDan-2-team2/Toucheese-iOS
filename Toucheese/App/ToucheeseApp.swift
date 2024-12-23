//
//  ToucheeseApp.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import GoogleSignIn

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
                            .toucheeseAlert(alert: $navigationManager.alert)
                            .toucheeseToast(toast: $navigationManager.toast)
                    }
                    .fullScreenCover(item: $navigationManager.fullScreenCover) { fullScreenCover in
                        navigationManager.build(fullScreenCover)
                    }
                    
            }
            .onOpenURL { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                } else {
                    GIDSignIn.sharedInstance.handle(url)
                }
            }
                
        }
        .environmentObject(navigationManager)
    }
}
