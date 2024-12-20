//
//  SocialType.swift
//  Toucheese
//
//  Created by 유지호 on 12/20/24.
//

import Foundation

enum SocialType: String {
    case kakao
    case google
    case apple
    
    var logo: String {
        switch self {
        case .kakao: "kakao_logo"
        case .google: "google_logo"
        case .apple: "apple_logo"
        }
    }
    
    var title: String {
        switch self {
        case .kakao: "카카오"
        case .google: "구글"
        case .apple: "Apple"
        }
    }
}
