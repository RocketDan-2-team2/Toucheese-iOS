//
//  AppDelegate.swift
//  Toucheese
//
//  Created by SunJoon Lee on 12/22/24.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    
    // 앱이 켜졌을 때, 호출되는 메서드 (앱이 메모리에 로드되고, 실행을 시작할 때 호출되는 메서드)
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Firebase 초기화(설정)
        FirebaseApp.configure()
        
        // Notification을 위한 Permission 받음
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        // UNUserNotificationCenterDelegate를 구현한 메서드를 실행시킴 - Apple's Push Notification service (APNs)에 link함.
        application.registerForRemoteNotifications()
        
        // 파이어베이스 Meesaging 설정 - AppDelegate를 FCM의 델리게이트로 지정
        Messaging.messaging().delegate = self
        
        // 앱 실행 시 사용자에게 알림 허용 권한을 받음 - AppDelegate를 Local Notification의 델리게이트로 지정
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    
    // fcm 토큰이 등록 되었을 때 -
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 테스트를 위해 Device Token을 출력
        print("APNS token: \(deviceToken.debugDescription)")
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension AppDelegate: MessagingDelegate {
    
    // MessagingDelegate 설정 - FCM 등록 토큰을 받았을 때
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        print("Firebase registration Token: \(String(describing: fcmToken))")
        
        // Store this token to firebase and retrieve when to send message to someone...
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        
        // Store token in Firestore For Sending Notifications From Server in Future...
        
        print(dataDict)
        
    }
}

// User Notifications...[AKA InApp Notification...]

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 푸시 메세지가 앱이 켜져있을 때 나올떄
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        
        // Do Something With MSG Data...
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print("userNotificationCenter(_:willPresent:withCompletionHandler:å): ", userInfo)
        
        completionHandler([[.banner, .badge, .sound]])
    }
    
    // 푸시메세지를 받았을 떄
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        // Do Something With MSG Data...
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print("userNotificationCenter(_:didReceive:withCompletionHandler:å): ", userInfo)
        
        completionHandler()
    }
}
