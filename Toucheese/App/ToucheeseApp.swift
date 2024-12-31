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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var navigationManager = NavigationManager()
    @StateObject private var authNavigationManager = AuthNavigationManager()
    
    @AppStorage("isLogined") private var isLogined: Bool = false
    
    init() {
        KakaoSDK.initSDK(appKey: ToucheeseEnv.kakaoAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            if isLogined {
                ToucheeseTabView()
                    .accentColor(.gray09)
                    .toucheeseAlert(alert: $navigationManager.alert)
                    .toucheeseToast(toast: $navigationManager.toast)
                    .environmentObject(navigationManager)
            } else {
                NavigationStack(path: $authNavigationManager.path) {
                    authNavigationManager.build(.login)
                        .navigationDestination(for: Destination.Auth.self) { destination in
                            authNavigationManager.build(destination)
                        }
                }
                .accentColor(.gray09)
                .environmentObject(authNavigationManager)
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    } else {
                        GIDSignIn.sharedInstance.handle(url)
                    }
                }
            }
            
            
        }
    }
}
