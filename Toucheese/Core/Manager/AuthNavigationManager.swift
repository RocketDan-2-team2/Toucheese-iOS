//
//  AuthNavigationManager.swift
//  Toucheese
//
//  Created by 유지호 on 12/27/24.
//

import SwiftUI

final class AuthNavigationManager: ObservableObject {
    @Published var path: [Destination.Auth] = []
    
    @Published var alert: AlertType?
    @Published var toast: ToastType?
    
    
    func push(_ scene: Destination.Auth) {
        path.append(scene)
    }
    
    func pop(_ depth: Int) {
        path.removeLast(depth)
    }
    
    func popToRoot() {
        path.removeLast(path.count - 1)
    }
    
    
    @ViewBuilder
    func build(_ scene: Destination.Auth) -> some View {
        switch scene {
        case .login:
            LoginView()
        case .nickname:
            SignUpNicknameView()
        case .complete:
            SignUpCompleteView()
        }
    }
    
}


enum Destination {
    enum Auth {
        case login
        case nickname
        case complete
    }
}
