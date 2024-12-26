//
//  UserDefaultsManager.swift
//  neggu
//
//  Created by 유지호 on 8/6/24.
//

import Foundation

enum UserDefaultsKey {
    enum Auth {
        @UserDefaultsWrapper<String>("accessToken") static var accessToken
        @UserDefaultsWrapper<String>("refreshToken") static var refreshToken
        @UserDefaultsWrapper<Bool>("isLogined") static var isLogined
    }
    
    enum User {
        @UserDefaultsWrapper<String>("fcmToken") static var fcmToken
    }
}

extension UserDefaultsKey {
    
    static func clearUserData() {
        UserDefaultsKey.Auth.accessToken = nil
        UserDefaultsKey.Auth.refreshToken = nil
        UserDefaultsKey.Auth.isLogined = nil
    }
    
    static func clearPushToken() {
        UserDefaultsKey.User.fcmToken = nil
    }
    
}


@propertyWrapper
private struct UserDefaultsWrapper<T> {
    private let key: String
    
    init(_ key: String) {
        self.key = key
    }
    
    var wrappedValue: T? {
        get {
            return UserDefaults.standard.object(forKey: key) as? T
        }
        
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: key)
            } else {
                UserDefaults.standard.setValue(newValue, forKey: key)
            }
        }
    }
}
