//
//  UserDefaultsManager.swift
//  neggu
//
//  Created by 유지호 on 8/6/24.
//

import Foundation

enum UserDefaultsKey {
    case accountToken
    case fcmToken
    
    case showTabFlow
}

struct UserDefaultsManager {
    @UserDefaultsWrapper<String>(.accountToken) static var accountToken
    @UserDefaultsWrapper<String>(.fcmToken) static var fcmToken
    @UserDefaultsWrapper<Bool>(.showTabFlow) static var showTabFlow
}

@propertyWrapper
private struct UserDefaultsWrapper<T> {
    private let key: UserDefaultsKey
    
    init(_ key: UserDefaultsKey) {
        self.key = key
    }
    
    var wrappedValue: T? {
        get {
            return UserDefaults.standard.object(forKey: "\(key)") as? T
        }
        
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: "\(key)")
            } else {
                UserDefaults.standard.setValue(newValue, forKey: "\(key)")
            }
        }
    }
}
