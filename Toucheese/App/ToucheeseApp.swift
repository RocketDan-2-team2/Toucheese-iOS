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
    // AppDelegate를 SwiftUI 앱 생명주기에 통합
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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
                    .toucheeseAlert(alert: $navigationManager.alert)
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
